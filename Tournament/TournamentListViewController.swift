//
//  TournamentListViewController.swift
//  Tournament
//
//  Created by Raichu on 1/7/16.
//  Copyright © 2016 Richard. All rights reserved.
//

import UIKit
import CoreData

class TournamentListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    // MARK: UI Outlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties

    var tournaments = [NSManagedObject]() // Where we store our tournaments data. We can use, create, edit, save, and delete entries with this var.
    
    // MARK: View Controller
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tournaments.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tournamentsCellID")
        let tournament = tournaments[indexPath.row]
        let numberOfContestants = tournaments[indexPath.row].valueForKey("contestants")?.count
        let tournamentDate = tournament.valueForKey("date") as! String
        let tournamentType = tournament.valueForKey("type") as! String
        let detailText = " \(tournamentDate) |  \(tournamentType)  |  \(numberOfContestants!) Contestants"
        
        cell?.textLabel?.text = tournament.valueForKey("name") as? String
        cell?.detailTextLabel?.text = detailText
        
        return cell!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		deleteData(indexPath.row)
        
		fetchData()
        tableView.reloadData()
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {        
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("bracketVC") as! DisplayBracketsViewController
        
		nextViewController.tournamentIndex = indexPath.row
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }
    
    // MARK: Core Data
    
    func fetchData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName:"Tournament")
        
        do {
            let results = try managedObjectContext.executeFetchRequest(fetchRequest)
            tournaments = results as! [Tournament]
        } catch let error as NSError {
            print("Could not fetch data: \(error), \(error.userInfo)")
        }
    }
    
    func deleteData(index: Int) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        managedObjectContext.deleteObject(tournaments[index])
        
        do {
            try managedObjectContext.save()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
    }
    
}

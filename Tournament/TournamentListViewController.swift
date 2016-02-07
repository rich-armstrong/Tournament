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

    var tournaments = [NSManagedObject]() // tournament data - NSManagedObject is way to talk to a SQLLite DB with Swift
    
    // MARK: View Controller
    
    override func viewWillAppear(animated: Bool) {
        // Set up the view before it appears since we are queueing data. Else, there would be a delay when we got to this screen.
        
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
        // Populate tableView with a list of all the previously created tournaments
        
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
        // adds the option of swiping a tableViewCell to the left to have the option to delete a tournament
        
		deleteData(indexPath.row)
		fetchData()
        tableView.reloadData()
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // when a tableViewCell is selected -> display the bracket in the next ViewController (VC)
        
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("bracketVC") as! DisplayBracketsViewController
        
		nextViewController.tournamentIndex = indexPath.row
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }
    
    // MARK: Core Data
    
    func fetchData() {
        // fetch all of our tournaments

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
        // delete an index from core data (delete a Tournament from the Tournaments Database)
        
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

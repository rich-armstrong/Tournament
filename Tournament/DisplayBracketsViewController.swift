//
//  DisplayBracketsViewController.swift
//  Tournament
//
//  Created by Raichu on 1/7/16.
//  Copyright © 2016 Richard. All rights reserved.
//

import UIKit
import CoreData

class DisplayBracketsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: UI Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Properties
    
    var tournaments = [NSManagedObject]() // Where we store our tournaments data. We can use, create, edit, save, and delete entries with this var.
    
    // MARK: View Controller
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        titleLabel.text = "Tournament Name" //tournamentInfo["TournamentName"] as? String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let fights = tournamentInfo["Fights"] as! [[String]]
//        
//        return fights.count
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("fightCell") as! FightCell
//        var fights = tournamentInfo["Fights"] as! [[String]]
//        
//        cell.challengeNumberLabel.text = "Challenge \(indexPath.row + 1)"
//        cell.firstContestantLabel.text = "\(fights[indexPath.row][0])"
//		cell.secondContestantLabel.text = "\(fights[indexPath.row][1])"
        
        return cell
    }
    
    // MARK: Actions

    @IBAction func backPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Core Data
    
    func fetchData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName:"Tournament")
        
        do {
            let results = try managedObjectContext.executeFetchRequest(fetchRequest)
            tournaments = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch data: \(error), \(error.userInfo)")
        }
    }
}

// MARK: Table View Cell

public class FightCell: UITableViewCell {
    @IBOutlet weak var challengeNumberLabel: UILabel!
    @IBOutlet weak var firstContestantLabel: UILabel!
    @IBOutlet weak var secondContestantLabel: UILabel!
}

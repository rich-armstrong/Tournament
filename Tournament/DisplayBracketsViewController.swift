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
    
    var tournaments = [Tournament]() // Where we store our tournaments data. We can use, create, edit, save, and delete entries with this var.
    var tournamentIndex = 0
    var tournament: Tournament?
    var fights: [Fight]?
    
    // MARK: View Controller
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: setup
    
    func setup() {
        // fetch all of our tournaments
        fetchTournaments()
        
        // grab the one we need to use to populate the tableView, index 999 is a signal to grab the last created tournment
        tournamentIndex != 999 ? ( tournament = tournaments[tournamentIndex] ) : ( tournament = tournaments.last )
        fights = tournament?.fights?.allObjects as? [Fight]
        titleLabel.text = tournament!.valueForKey("name") as? String
    }

    // MARK: Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fights!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("fightCell") as! FightCell

        // populate the cells
        cell.challengeNumberLabel.text = "Challenge \(indexPath.row + 1)"
        cell.firstContestantLabel.text = "\(fights![indexPath.row].contestantOne!)"
		cell.secondContestantLabel.text = "\(fights![indexPath.row].contestantTwo!)"
        
        return cell
    }
    
    // MARK: Actions

    @IBAction func backPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Core Data
    
    func fetchTournaments() {
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
}

// MARK: Table View Cell

public class FightCell: UITableViewCell {
    @IBOutlet weak var challengeNumberLabel: UILabel!
    @IBOutlet weak var firstContestantLabel: UILabel!
    @IBOutlet weak var secondContestantLabel: UILabel!
}

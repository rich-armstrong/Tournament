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
    @IBOutlet weak var nextBracketView: UIView!
    
    // MARK: Properties
    
    var tournaments = [Tournament]()
    var tournamentIndex = 0
    var tournament: Tournament?
    var fights: [Fight]?
    
    // MARK: View Controller
    
    override func viewWillAppear(animated: Bool) {
        // Set up the view before it appears since we are queueing data. Else, there would be a delay when we got to this screen.

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
        
        // grab the one we need to use to populate the tableView. index 999 is a signal to grab the last created tournment
        tournamentIndex != 999 ? ( tournament = tournaments[tournamentIndex] ) : ( tournament = tournaments.last )
        fights = tournament?.fights?.allObjects as? [Fight]
        titleLabel.text = tournament!.valueForKey("name") as? String
        
        let keepingScore = true
        
        if keepingScore {
           nextBracketView.hidden = false
        }
    }

    // MARK: Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fights!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("fightCell") as! FightCell

        // populate the cells
        cell.challengeNumberLabel.text = "Challenge \(indexPath.row + 1)"

        cell.firstContestantButton.tag = 100 + (indexPath.row * 10) + 0
        cell.secondContestantButton.tag = 100 + (indexPath.row * 10) + 1
        
		cell.secondContestantButton.setTitle("\(fights![indexPath.row].contestantTwo!)", forState: .Normal)
        cell.firstContestantButton.setTitle("\(fights![indexPath.row].contestantOne!)", forState: .Normal)
        
        return cell
    }
    
    // MARK: Actions

    @IBAction func backPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func winnerPressed(sender: UIButton) {
        // we could use tags for the contestant 1 and contestant 2
        // such as row 1 contestant 1 would equal tag of 101
        // row 2 contestant 2 = 111
        
        /* TODO: This will work for when the data is selected in a cell; however, scrolling the dataview
           will throw off the cells and show visual bugs. The easiest way to stop this from happening is
           by creating an array of cells that holds this data to reload the cells from when scrolling.
        */
        
        let tagValue = sender.tag
        
        if sender.tag % 2 == 0 {
        	sender.selected = true
            let button:UIButton = self.view.viewWithTag(tagValue + 1) as! UIButton
            button.selected = false
        } else {
            sender.selected = true
            let button:UIButton = self.view.viewWithTag(tagValue - 1) as! UIButton
            button.selected = false
        }
    }
    
    @IBAction func finishBracket() {
        let tournamentType = tournament!.valueForKey("type") as! String
        
        if tournamentType == "Single Elimination" {
            print("Single Elimination = \(tournamentType)")
            
            // TODO: check to see if tableViewCells have at least 1 selected winner
            //		with that data, create a winners list
            //		if the winnersList.count > 1
            //			createBracker(winnersList)
            //		else
            //			whoever that lucky guy is wins the medal
            //			find out who places where
            // 			displayMedals()
            
        } else if tournamentType == "Double Elimination" {
            print("Double Elimination = \(tournamentType)")
            
            // TODO: check to see if tableViewCells have at least 1 selected winner
            //		with that data, create a winners list
            //		if the winnersList.count > 1
            //			createBracker(winnersList)
            //			createLosersBracket(winnersOfLosersBracket + latestLosers)
            //		else
            //			whoever that lucky guy is wins the medal
            //			find out who places where
            // 			displayMedals()
            
        } else if tournamentType == "Round Robin" {
            print("Round Robin = \(tournamentType)")
        }
    }
    
    // MARK: Core Data
    
    func fetchTournaments() {
        // Grab the database of tournaments - don't worry about size, the tournaments are tiny Strings and Ints.
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

    // MARK: helper functions
    
    func createWinnersBracket() -> [String] {
        // TODO:
        return [""]
    }
    
    func createLosersBracket() -> [String] {
        // TODO:
        return [""]
    }
    
    func displayMedals() -> [String: Int] {
        
        // TODO: check the tournament.contestants for the people with the most wins and put them in the order of winners, return the top four with the placement they get
        
        /* TODO: we return a dictionary here instead of an array because a weird rule of tournaments can argue over who gets 2nd place vs who gets 3rd place
			if (loserBracketCanEarnSecondPlace) {
        
        	} else {
        
        	}
        */
        
        return ["goldMedalist":1, "silverMedalist":2, "bronzeMedalist":3, "copperMedalist":4]
    }
    
}

// MARK: Table View Cell

public class FightCell: UITableViewCell {
    @IBOutlet weak var challengeNumberLabel: UILabel!
    @IBOutlet weak var firstContestantButton: UIButton!
    @IBOutlet weak var secondContestantButton: UIButton!
}

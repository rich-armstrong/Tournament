//
//  ViewController.swift
//  Tournament
//
//  Created by Raichu on 1/3/16.
//  Copyright © 2016 Richard. All rights reserved.
//

import UIKit
import CoreData

// MARK: View Controller

class CreationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

	// MARK: UI Outlets
    
    @IBOutlet weak var bracketNameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberOfContestantsOutlet: UITextField!
    @IBOutlet weak var singleEliminationOutlet: UIButton!
    @IBOutlet weak var doubleEliminationOutlet: UIButton!
    @IBOutlet weak var roundRobinOutlet: UIButton!

    // MARK: Class Variables
    
    var contestantNames: [String] = []
//    var rowBeingEdited: Int? = nil		// WARNING: CHECK TO SEE IF THIS IS BEING USED
    var currentTextField: UITextField = UITextField()
    var textFieldArray: [UITextField] = []
    
    // once the datamodel has been set up we will use
    var tournaments = [NSManagedObject]() // Where we store our tournaments data. We can use, create, edit, save, and delete entries with this var.
    
    // MARK: View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("CellID") as! ContestantsCell
        
        cell.contestantInputField?.placeholder = "Name Contestant \(indexPath.row + 1)"
        cell.contestantInputField.delegate = self
        cell.contestantInputField.tag = indexPath.row
        
        textFieldArray.insert(cell.contestantInputField, atIndex: cell.contestantInputField.tag)
        
        return cell
    }

    func textFieldDidEndEditing(textField: UITextField) {
        let row = textField.tag
        
        if textField.tag == 1001 {
            if Int(textField.text!)! > 32 {
                textField.text = "32"
            } else if Int(textField.text!)! < 2 {
                textField.text = "2"
            }
        }
        
        if row >= contestantNames.count {
            for var addRow = contestantNames.count; addRow <= row; addRow++ {
                contestantNames.append("") // this adds blank rows in case the user skips rows
            }
        }
        
        contestantNames[row] = textField.text!
//        rowBeingEdited = nil
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
//        rowBeingEdited = textField.tag
        currentTextField = textField
    }
    
	// MARK: Actions
    
    @IBAction func createTournamentPressed(sender: UIButton) {
        currentTextField.resignFirstResponder()
        
        // tournament names must be unquie        
        if bracketNameTextField.text != nil && bracketNameTextField.text != "" {
            
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("bracketVC") as! DisplayBracketsViewController
//            
//            self.presentViewController(nextViewController, animated:true, completion:nil)
            
            saveTournamentData()
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            /* check to find out if everyone has different names */
            /* add a popup to display this message if a tournament is incomplete*/
            
            print("Please verify that the tournament and all of the contestants have a name.")
        }
    }

    @IBAction func tournamentTypeSelected(sender: UIButton) {
        singleEliminationOutlet.selected = false
        doubleEliminationOutlet.selected = false
        roundRobinOutlet.selected = false

        sender.selected = true
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Data Model
    
    func saveTournamentData() {
        // Retrieve the data model from the app delegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext: NSManagedObjectContext = appDelegate.managedObjectContext
        
        // Create a new entity for the data model
        let entity = NSEntityDescription.entityForName("Tournament", inManagedObjectContext: managedContext)
        let contestant = NSEntityDescription.entityForName("Contestant", inManagedObjectContext: managedContext)

        let tournament = Tournament(entity: entity!, insertIntoManagedObjectContext: managedContext)
        //var newContestant = Contestant(entity: contestant!, insertIntoManagedObjectContext: managedContext)
        
        var contestants:Array<Contestant> = []
        
        // Adding data to the entity
        tournament.setValue(getDate(), forKey: "date")
        tournament.setValue(bracketNameTextField.text!, forKey: "name")
        tournament.setValue("Round Robin", forKey: "type")
//        tournament.setValue(NSSet(array: contestantNames), forKey: "contestants")
        
        for eachContestant in contestantNames {
            let newContestant = Contestant(entity: contestant!, insertIntoManagedObjectContext: managedContext)
            
            newContestant.setValue(eachContestant, forKey: "name")
            newContestant.setValue(0, forKey: "wins")
            
            contestants.append(newContestant)
        }

        print(contestants)
        
        tournament.setValue(NSSet(array: contestants), forKey: "contestants")
        
        print(tournament.valueForKey("contestants"))

        
        // add the tournament to the data source
        do {
            try managedContext.save()
            tournaments.append(tournament)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // MARK: Helper functions
    
    func getDate() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        
		// return example: "Jan 18, 2016"
        return formatter.stringFromDate(NSDate())
    }
}

// MARK: TableViewCell

public class ContestantsCell: UITableViewCell {
    @IBOutlet weak var contestantInputField: UITextField!
}

//// MARK: Extensions
//
//@IBAction func ShuffleContestantsPressed(sender: AnyObject) {
//    currentTextField.resignFirstResponder()
//    contestantNames.shuffle()
//    
//    var index = 0
//    
//    for textField in textFieldArray {
//        textField.text = contestantNames[index]
//        
//        index++
//    }
//}
//
//extension Array {
//    // REWRITE THIS FUNCTION!
//    
//    mutating func shuffle() {
//        if count < 2 { return }
//        for i in 0..<(count - 1) {
//            let j = Int(arc4random_uniform(UInt32(count - i))) + i
//
//            if j != i {
//                swap(&self[i], &self[j])
//            }
//        }
//    }
//}

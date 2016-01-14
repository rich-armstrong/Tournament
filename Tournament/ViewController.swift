//
//  ViewController.swift
//  Tournament
//
//  Created by Raichu on 1/3/16.
//  Copyright © 2016 Richard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var bracketNameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberOfContestantsLabel: UILabel!
    @IBOutlet weak var contestantsStepper: UIStepper!
    
    var numberOfContestants : Int?
    var contestantNames: [String] = []
    var rowBeingEdited : Int? = nil
    var tournamentInfo : [String:Any]? = ["TournamentName":""]
    var currentTextField : UITextField = UITextField()
    var textFieldArray : [UITextField] = []
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberOfContestants = (numberOfContestantsLabel.text! as NSString).integerValue
        contestantsStepper.value = Double(numberOfContestants!)
    }

    @IBAction func stepperChanged(sender: AnyObject) {
        numberOfContestants = Int(contestantsStepper.value)
        numberOfContestantsLabel.text = "\(numberOfContestants!)"

        if contestantNames.count > numberOfContestants {
        	contestantNames = []
        }

        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfContestants!
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
        
        if row >= contestantNames.count {
            for var addRow = contestantNames.count; addRow <= row; addRow++ {
                contestantNames.append("") // this adds blank rows in case the user skips rows
            }
        }
        
        contestantNames[row] = textField.text!
        rowBeingEdited = nil
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        rowBeingEdited = textField.tag
        currentTextField = textField
    }
    
    @IBAction func createTournamentPressed(sender: UIButton) {
        
        /*
        * time stamp and date the tournment when "Create Tournament" is pressed
        * if the list is longer than the screen, verify that the list is reloading
        the right data for the right cells and not deleting names that have already been typed in
        */
        
        currentTextField.resignFirstResponder()
        
        if bracketNameTextField.text != nil && bracketNameTextField.text != "" && self.contestantNames.count == numberOfContestants {
            let fourRounds = FourRounds()
            tournamentInfo = ["TournamentName":bracketNameTextField.text!,
                    "NumberOfContestants":numberOfContestants!,
                    "DateCreated":"",
                    "Contestants":contestantNames,
                    "Fights":fourRounds.generateFights(contestantNames),
                    "Winners":[""]]
            
//            var tournaments = userDefaults.objectForKey("tournaments") as! Array
//            
//            userDefaults.setObject(tournamentInfo, forKey: "tournaments") as
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("bracketVC") as! DisplayBracketsViewController
            
            nextViewController.tournamentInfo = tournamentInfo!
            self.presentViewController(nextViewController, animated:true, completion:nil)
            
        } else {
            /* check to find out if everyone has different names */
            /* add a popup to display this message if a tournament is incomplete*/
            
            print("Please verify that the tournament and all of the contestants have a name.")
        }
    }
    
    @IBAction func ShuffleContestantsPressed(sender: AnyObject) {
        currentTextField.resignFirstResponder()
		contestantNames.shuffle()
        
        var index = 0
        
        for textField in textFieldArray {
            textField.text = contestantNames[index]
            
            index++
        }
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

public class ContestantsCell: UITableViewCell {
    @IBOutlet weak var contestantInputField: UITextField!
}

extension Array {
    mutating func shuffle() {
        if count < 2 { return }
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i

            if j != i {
                swap(&self[i], &self[j])
            }
        }
    }
}

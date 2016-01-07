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
    
    /*
		* make sure tournament name is filled in and valid
    	* check that each contestant has a name
    		* make sure each contestant name is different from the others
    	* time stamp and date the tournment when "Create Tournament" is pressed
		* if the list is longer than the screen, verify that the list is reloading
          the right data for the right cells and not deleting names that have already been typed in
	*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberOfContestants = (numberOfContestantsLabel.text! as NSString).integerValue
        contestantsStepper.value = Double(numberOfContestants!)
    }

    @IBAction func stepperChanged(sender: AnyObject) {
        numberOfContestants = Int(contestantsStepper.value)
        numberOfContestantsLabel.text = "\(numberOfContestants!)"
        
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
    }
    
    @IBAction func createTournamentPressed(sender: UIButton) {
        // this will also takes us to the next viewController
        
        if bracketNameTextField.text != nil {
            
            /*
				WIP: This needs to save this information into a dictionary and then pass it to the next viewController
			*/
            
//            print("\(bracketNameTextField.text!) : \(contestantNames)")
            let fourRounds = FourRounds()
//            print(fourRounds.generateFights(contestantNames))
            
            let tournamentInfo = ["TournamentName":bracketNameTextField.text!,
					 "NumberOfContestants":numberOfContestants!,
                	 "DateCreated":"",
                	 "Contestants":contestantNames,
                     "Fights":fourRounds.generateFights(contestantNames),
                     "Winners":[""]]
            
            print(tournamentInfo)
        }
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

public class ContestantsCell: UITableViewCell {
    @IBOutlet weak var contestantInputField: UITextField!
}

//
//  TournamentListViewController.swift
//  Tournament
//
//  Created by Raichu on 1/7/16.
//  Copyright © 2016 Richard. All rights reserved.
//

import UIKit

class TournamentListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    
	let userDefaults = NSUserDefaults.standardUserDefaults()
    var totalNumberOfTournaments: Int = 0
    var allTournaments = []
    var tournamentInfo : [String:Any]? = ["TournamentName":""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

		// allTournaments = userDefaults.objectForKey("tournaments")
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return totalNumberOfTournaments
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tournamentsCellID")
        
        cell?.textLabel?.text = "First Tournament"
        cell?.detailTextLabel?.text = "Jan 7, 2015"
        
        return cell!
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let fourRounds = FourRounds()
        tournamentInfo = ["TournamentName":"First Tournament",
            "NumberOfContestants":3,
            "DateCreated":"",
            "Contestants":["Billy", "Bob", "Bubba"],
            "Fights":fourRounds.generateFights(["Billy", "Bob", "Bubba"]),
            "Winners":[""]]
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("bracketVC") as! DisplayBracketsViewController
        
        nextViewController.tournamentInfo = tournamentInfo!
        self.presentViewController(nextViewController, animated:true, completion:nil)

    }

}

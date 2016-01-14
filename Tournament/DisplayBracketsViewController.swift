//
//  DisplayBracketsViewController.swift
//  Tournament
//
//  Created by Raichu on 1/7/16.
//  Copyright © 2016 Richard. All rights reserved.
//

import UIKit

class DisplayBracketsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var tournamentInfo : [String:Any] = ["TournamentName":""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = tournamentInfo["TournamentName"] as? String
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fights = tournamentInfo["Fights"] as! [[String]]
        
        return fights.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("fightCell") as! FightCell
        var fights = tournamentInfo["Fights"] as! [[String]]
        
        cell.challengeNumberLabel.text = "Challenge \(indexPath.row + 1)"
        cell.firstContestantLabel.text = "\(fights[indexPath.row][0])"
		cell.secondContestantLabel.text = "\(fights[indexPath.row][1])"
        
        return cell
    }

    @IBAction func backPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

public class FightCell: UITableViewCell {
    @IBOutlet weak var challengeNumberLabel: UILabel!
    @IBOutlet weak var firstContestantLabel: UILabel!
    @IBOutlet weak var secondContestantLabel: UILabel!
}

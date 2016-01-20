//
//  SingleElimination.swift
//  Tournament
//
//  Created by Raichu on 1/20/16.
//  Copyright © 2016 Richard. All rights reserved.
//

import UIKit

class Elimination: NSObject {
        
	func generateFights(players: [String]) -> [[String]] {
        var index = 0
        var fights: [[String]] = []
        
        // generate a fight for every player
        for _ in players {
            // since each player will only fight once, only create a fight with every other player
            if index % 2 == 0 {
                var newFight:[String]
                
                // if we have an odd number of players we need to have an auto win and pass the player to the next round
                if index + 1 < players.count {
                    newFight = [players[index], players[index + 1]]
                } else {
                    newFight = [players[index], "Pass"]
                }
                
                // add the fight we created to the over all list
                fights.append(newFight)
            }
            
            index++
        }
        
        // return all of the fights
        return fights
    }
}

//
//  FourRounds.swift
//  Tournament
//
//  Created by Raichu on 1/7/16.
//  Copyright © 2016 Richard. All rights reserved.
//

import UIKit

class FourRounds: NSObject {

    func generateFights(players: [String]) -> [[String]] {
        var index = 0 // keep track of the index of the player we are working with
        var fights: [[String]] = []
        
        // let's set up an array of fights for each player we have in the players list
        for player in players {
            var fightOne, fightTwo: [String] // each player will have two fights, first with the person two behind them, secondly with the person directly behind them
            var firstContestant = index + 2
            var secondContestant = index + 1
            
            let lastPlayerIndex = players.count - 1 // if we are about to run out of players circle around to the beginning of the list
            
            if (firstContestant <= lastPlayerIndex) && (secondContestant <= lastPlayerIndex) {
                fightOne = [player, players[firstContestant]]
                fightTwo = [player, players[secondContestant]]
            } else if !(firstContestant <= lastPlayerIndex) && (secondContestant <= lastPlayerIndex) {
                // if you are the second to last in the list, you will have to compete with first players[0], followed by players[players.count - 1] (last player)
                firstContestant = 0
                secondContestant = index + 1
                
                fightOne = [player, players[firstContestant]]
                fightTwo = [player, players[secondContestant]]
            } else {
                firstContestant = abs(index - players.count)
                secondContestant = abs(index - players.count) - 1
                
                fightOne = [player, players[firstContestant]]
                fightTwo = [player, players[secondContestant]]
            }
            
            // add the two fights to fights
            fights.append(fightOne)
            fights.append(fightTwo)
            
            index++
        }
        
        return fights
    }
}

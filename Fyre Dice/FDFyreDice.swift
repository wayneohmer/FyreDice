//
//  FDFyreDice.swift
//  Fyre Dice
//
//  Created by Wayne Ohmer on 10/8/17.
//  Copyright © 2017 Wayne Ohmer. All rights reserved.
//

import UIKit

class FDFyreDice {
    
    var dice = [Int:Int]()
    var diceResults = [Int:Int]()
    var modifier = 0
    
    var rollValue:Int {
        get {
            var returnValue = 0
            for (_,value) in self.diceResults {
                returnValue += value
            }
            return returnValue + self.modifier
        }
    }
    
    var max:Int {
        get {
            var returnValue = 0
            for (die,multiplier) in self.dice {
                returnValue += multiplier*die
            }
            return returnValue + self.modifier
        }
    }
    
    var min:Int {
        get {
            var returnValue = 0
            for (_,multiplier) in self.dice {
                returnValue += multiplier
            }
            return returnValue + self.modifier
        }
    }
    
    var numberOfDice:Int {
        get {
            var returnValue = 0
            for (_,multiplier) in self.dice {
                returnValue += multiplier
            }
             return returnValue
        }
    }
    
    convenience init(with fyreDice:FDFyreDice) {
        self.init()
        self.dice = fyreDice.dice
        self.modifier = fyreDice.modifier
    }
    
    func add(multipier:Int, d die:Int) {
        if var newValue = self.dice[die] {
            newValue += multipier
            self.dice[die] = newValue
        } else {
            self.dice[die] = multipier
        }
    }
    
    func clear() {
        self.dice.removeAll()
        self.diceResults.removeAll()
        self.modifier = 0
    }
    
    func roll() {
        for (die,multiplier) in dice {
            var thisResult = 0
            for _ in 1 ... multiplier {
                thisResult += Int(arc4random_uniform(UInt32(die)) + 1)
            }
            self.diceResults[die] = thisResult
        }
    }
    
    func display() -> String {
        var returnString = ""
        for (die,multiplier) in self.dice.sorted(by: {$0 < $1}) {
            if multiplier != 0 {
                if returnString != "" {
                    let sign = multiplier > 0 ? "+" : ""
                    returnString += sign
                }
                returnString += "\(multiplier)d\(die)"
            }
        }
        if self.modifier != 0 {
            let sign = modifier > 0 ? "+" : ""
            returnString += "\(sign)\(self.modifier)"
        }
        return returnString == "" ? " " : returnString
    }
    
    func resultDisplay () -> String {
        var returnString = ""
        for (die,result) in self.diceResults.sorted(by: {$0 < $1}) {
            returnString += "\(self.dice[die] ?? 0)d\(die)(\(result))"
        }
        return returnString
    }
}

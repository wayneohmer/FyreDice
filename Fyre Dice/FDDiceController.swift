//
//  ViewController.swift
//  Fyre Dice
//
//  Created by Wayne Ohmer on 10/7/17.
//  Copyright © 2017 Wayne Ohmer. All rights reserved.
//

import UIKit
import AudioToolbox


class FDDiceController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var resultDisplayLabel: UILabel!
    @IBOutlet weak var rollValueLabel: UILabel!
  
    @IBOutlet weak var d4Button: UIButton!
    @IBOutlet weak var d6Button: UIButton!
    @IBOutlet weak var d8Button: UIButton!
    @IBOutlet weak var d10Button: UIButton!
    @IBOutlet weak var d12Button: UIButton!
    @IBOutlet weak var d20Button: UIButton!
    @IBOutlet weak var d100Button: UIButton!
    
    @IBOutlet weak var plus1Button: UIButton!
    @IBOutlet weak var plus2Button: UIButton!
    @IBOutlet weak var plus3Button: UIButton!
    @IBOutlet weak var plus4Button: UIButton!
    @IBOutlet weak var plus5Button: UIButton!
    @IBOutlet weak var plus6Button: UIButton!
    @IBOutlet weak var plus7Button: UIButton!
    @IBOutlet weak var plus8Button: UIButton!
    @IBOutlet weak var plus9Button: UIButton!
    @IBOutlet weak var plus10Button: UIButton!
    @IBOutlet weak var plus20Button: UIButton!
    @IBOutlet weak var plus30Button: UIButton!

    let deathSound = "DeathSound"
    let awwwSound = "Awww"
    let oneDieSound = "1die"
    let threeDieSound = "3dice"
    let tenDieSound = "10dice"
    
    var diceButtons = [UIButton]()
    var modifierButtons = [UIButton]()
    var soundUrls = [String:CFURL]()
    var hasRolled = false
    
    var dice = FDFyreDice()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.diceButtons = [self.d4Button,self.d6Button,self.d8Button,self.d10Button,self.d12Button,self.d20Button,self.d100Button]
        self.modifierButtons = [self.plus1Button,self.plus2Button,self.plus3Button,self.plus4Button,self.plus5Button,self.plus6Button,self.plus7Button,self.plus8Button,self.plus9Button,self.plus10Button,self.plus20Button,self.plus30Button,]
        self.makeSystemSounds()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func makeSystemSounds() {
        if let soundUrl = Bundle.main.url(forResource: self.deathSound, withExtension: "aif")  {
           self.soundUrls[self.deathSound] = soundUrl as CFURL
        }
        if let soundUrl = Bundle.main.url(forResource: self.awwwSound, withExtension: "aif") {
            self.soundUrls[self.awwwSound] = soundUrl as CFURL
        }
        if let soundUrl = Bundle.main.url(forResource: self.oneDieSound, withExtension: "aif") {
            self.soundUrls[self.oneDieSound] = soundUrl as CFURL
        }
        if let soundUrl = Bundle.main.url(forResource: self.threeDieSound, withExtension: "aif") {
            self.soundUrls[self.threeDieSound] = soundUrl as CFURL
        }
        if let soundUrl = Bundle.main.url(forResource: self.tenDieSound, withExtension: "aif") {
            self.soundUrls[self.tenDieSound] = soundUrl as CFURL
        }
    }
    
    @IBAction func rollTouched() {
        self.hasRolled = true
        self.dice.roll()
        self.rollValueLabel.text = "\(self.dice.rollValue)"
        self.resultDisplayLabel.text = self.dice.resultDisplay()
        var soundURL:CFURL?
        if self.dice.rollValue == self.dice.max {
            soundURL = self.soundUrls[self.deathSound]
        } else if self.dice.rollValue == self.dice.min  {
            soundURL = self.soundUrls[self.awwwSound]
        } else if self.dice.numberOfDice > 10 {
            soundURL = self.soundUrls[self.tenDieSound]
        } else if self.dice.numberOfDice > 3 {
            soundURL = self.soundUrls[self.threeDieSound]
        } else {
            soundURL = self.soundUrls[self.oneDieSound]
        }
        if let soundURL = soundURL {
            var soundId = SystemSoundID(0)
            AudioServicesCreateSystemSoundID(soundURL, &soundId)
            AudioServicesPlaySystemSoundWithCompletion(soundId) {
                AudioServicesDisposeSystemSoundID(soundId)
            }
        }
    }
    
    func diceChanged() {
        self.displayLabel.text = self.dice.display()
    }
    
    func swapSign(from:String, to new:String, in buttons:[UIButton]) {
        for button in buttons{
            let title = button.title(for: .normal)
            let newTitle = title?.replacingOccurrences(of: from, with: new)
            button.setTitle(newTitle, for: .normal)
        }
    }

    @IBAction func signTouched(_ sender: UIButton) {
        
        let buttonArray = sender.tag == 1 ? self.modifierButtons : self.diceButtons
 
        if sender.title(for: .normal) == "+" {
            sender.setTitle("-", for: .normal)
            self.swapSign(from:"-", to: "+", in: buttonArray)
        } else {
            sender.setTitle("+", for: .normal)
            self.swapSign(from:"+", to: "-", in: buttonArray)
        }
    }
    
    @IBAction func clearTouched() {
        self.dice.clear()
        self.displayLabel.text = " "
        self.resultDisplayLabel.text = " "
    }
    
    @IBAction func dieTouched(_ sender: UIButton) {
        if hasRolled {
            self.dice.clear()
            self.hasRolled = false
        }
        let components = sender.title(for: .normal)?.components(separatedBy: "d")
        if components?.count == 2 {
            self.dice.add(multipier: Int(components?[0] ?? "0") ?? 0 , d: Int(components?[1] ?? "0") ?? 0)
        }
        displayLabel.text = self.dice.display()
    }
    @IBAction func modifierTouched(_ sender: UIButton) {
        let modifier = Int(sender.title(for: .normal) ?? "0") ?? 0
        self.dice.modifier += modifier
        self.displayLabel.text = self.dice.display()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! FDSavedDiceController
        vc.diceController = self
    }


}


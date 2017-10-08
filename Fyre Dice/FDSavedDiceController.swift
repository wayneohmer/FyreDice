//
//  FDSavedDiceController.swift
//  Fyre Dice
//
//  Created by Wayne Ohmer on 10/8/17.
//  Copyright © 2017 Wayne Ohmer. All rights reserved.
//

import UIKit

class FDSavedDiceController: UITableViewController {

    var savedDice = [FDFyreDice]()
    var diceController:FDDiceController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    @IBAction func indexTouched(_ sender: UIButton) {
        if sender.tag >= self.savedDice.count {
            self.savedDice.append(FDFyreDice(with:self.diceController?.dice ?? FDFyreDice()))
        } else {
            if let dice = self.diceController?.dice {
                if dice.dice.count == 0 {
                    self.savedDice.remove(at: sender.tag)
                } else {
                    self.savedDice[sender.tag] = FDFyreDice(with:dice)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    @IBAction func dieTouched(_ sender: UIButton) {
        self.diceController?.dice = self.savedDice[sender.tag]
        self.diceController?.displayLabel.text = self.diceController?.dice.display()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.savedDice.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FDSavedDiceCell", for: indexPath) as! FDSavedDiceCell
       
        cell.indexButton.setTitle("S\(indexPath.row + 1)", for: .normal)
        cell.indexButton.tag = indexPath.row
        cell.dieButton.tag = indexPath.row
        if indexPath.row >= self.savedDice.count {
            cell.dieButton.setTitle(" ", for: .normal)
        } else {
            cell.dieButton.setTitle(self.savedDice[indexPath.row].display(), for: .normal)
        }

        return cell
    }

}
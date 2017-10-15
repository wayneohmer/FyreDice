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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = FDDisplayPreference.sharedDisplayPreferences.backgroundColor
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    @IBAction func indexTouched(_ sender: UIButton) {
        if let dice = self.diceController?.fyreDice {
            if sender.tag >= self.savedDice.count {
                if dice.dice.count > 0 {
                    self.savedDice.append(FDFyreDice(with:self.diceController?.fyreDice ?? FDFyreDice()))
                }
            } else {
                if dice.dice.count == 0 {
                    self.tableView.beginUpdates()
                    self.savedDice.remove(at: sender.tag)
                    self.tableView.deleteRows(at: [IndexPath(row:sender.tag, section:0)], with: .fade)
                    self.tableView.endUpdates()
                    return
                } else {
                    self.savedDice[sender.tag] = FDFyreDice(with:dice)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    @IBAction func dieTouched(_ sender: UIButton) {
        self.diceController?.fyreDice = self.savedDice[sender.tag]
        self.diceController?.displayLabel.text = self.diceController?.fyreDice.display
        self.diceController?.clearResult()
        self.diceController?.fixAdnvatageSwitches()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.savedDice.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FDSavedDiceCell", for: indexPath) as! FDSavedDiceCell
       
        cell.indexButton.setTitle("Save", for: .normal)
        cell.indexButton.tag = indexPath.row
        cell.dieButton.tag = indexPath.row
        if indexPath.row >= self.savedDice.count {
            cell.dieButton.setTitle(" ", for: .normal)
            cell.dieButton.isEnabled = false
        } else {
            cell.dieButton.setTitle(self.savedDice[indexPath.row].display, for: .normal)
            cell.dieButton.isEnabled = true
        }
        FDDisplayPreference.updateApearenceIn(views: cell.contentView.subviews)
        cell.contentView.backgroundColor = FDDisplayPreference.sharedDisplayPreferences.backgroundColor

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row < self.savedDice.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            self.savedDice.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            self.tableView.endUpdates()
        }
    }

}

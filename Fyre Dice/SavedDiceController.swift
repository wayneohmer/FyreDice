//
//  SavedDiceController.swift
//  Fyre Dice
//
//  Created by Wayne Ohmer on 10/8/17.
//  Copyright © 2017 Wayne Ohmer. All rights reserved.
//

import UIKit

class SavedDiceController: UITableViewController {

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
        guard let diceController = self.diceController else {
            return
        }
        let dice = diceController.fyreDice
        if sender.tag >= self.savedDice.count {
            if dice.dice.count > 0 {
                self.savedDice.append(FDFyreDice(with:diceController.fyreDice))
                let oops = FDOops(fyreDice: FDFyreDice(), type: FDOops.OopsType.save)
                oops.saveIndex = sender.tag
                diceController.oopsStack.append(oops)
            }
        } else {
            let oops = FDOops(fyreDice: self.savedDice[sender.tag], type: FDOops.OopsType.save)
            oops.saveIndex = sender.tag
            diceController.oopsStack.append(oops)
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
        self.tableView.reloadData()
    }
    
    @IBAction func dieTouched(_ sender: UIButton) {
        if let diceController = self.diceController {
            diceController.oopsStack.append(FDOops(fyreDice: FDFyreDice(with:diceController.fyreDice, includeResult:true), type: FDOops.OopsType.buttonTouch))
            diceController.fyreDice = FDFyreDice(with:self.savedDice[sender.tag])
            diceController.updateDisplay()
        }
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            if let diceController = self.diceController {
                let oops = FDOops(fyreDice: FDFyreDice(with:self.savedDice[indexPath.row]), type: FDOops.OopsType.saveDelete)
                oops.saveIndex = indexPath.row
                diceController.oopsStack.append(oops)
            }
            self.savedDice.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
        }
    }
}

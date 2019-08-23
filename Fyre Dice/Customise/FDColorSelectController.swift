//
//  FDColorSelectController.swift
//  Fyre Dice
//
//  Created by Wayne Ohmer on 10/15/17.
//  Copyright © 2017 Wayne Ohmer. All rights reserved.
//

import UIKit

class FDColorSelectController: UITableViewController {
    
    enum preferneceType: String {
        case button = "Button"
        case background = "Background"
        case text = "Text"
        case min = "Min"
        case max = "Max"

    }

    let buttonArray = [("Blue",UIImage(named:"BlueButton")!),("Purple",UIImage(named:"PurpleButton")!),("Green",UIImage(named:"GreenButton")!),("Red",UIImage(named:"RedButton")!),("Yellow",UIImage(named:"YellowButton")!),("Grey",UIImage(named:"GreyButton")!),("Brown",UIImage(named:"BrownButton")!)]
    
    let colorArray = [("Black",UIColor.black),("Blue",UIColor.blue),("Brown",UIColor.brown),("Cyan",UIColor.cyan),("Green",UIColor.green),("Magenta",UIColor.magenta),("Orange",UIColor.orange),("Purple",UIColor.purple),("Red",UIColor.red),("Yellow",UIColor.yellow),("White",UIColor.white)]
    
    var segueIdentifier = ""
    var prefType:preferneceType = .button
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 50
        self.tableView.tableFooterView = UIView()
        self.prefType = preferneceType.init(rawValue: self.segueIdentifier) ?? .button
       }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.prefType == .button ? self.buttonArray.count : self.colorArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FDColorSelectCell", for: indexPath) as! FDColorSelectCell
        
        if self.prefType == .button {
            cell.colorLabel.text = buttonArray[indexPath.row].0
            cell.colorButton.setBackgroundImage(buttonArray[indexPath.row].1, for: .normal)
        } else {
            cell.colorLabel.text = colorArray[indexPath.row].0
            cell.colorButton.backgroundColor = colorArray[indexPath.row].1
        }
        cell.accessoryType = .none
        switch self.prefType {
        case .button:
            cell.accessoryType = FDDisplayPreference.sharedDisplayPreferences.buttonImage == self.buttonArray[indexPath.row].1 ? .checkmark : .none
        case .background:
            cell.accessoryType = FDDisplayPreference.sharedDisplayPreferences.backgroundColor == self.colorArray[indexPath.row].1  ? .checkmark : .none
        case .text:
            cell.accessoryType = FDDisplayPreference.sharedDisplayPreferences.textColor == self.colorArray[indexPath.row].1  ? .checkmark : .none
        case .min:
            cell.accessoryType = FDDisplayPreference.sharedDisplayPreferences.minColor == self.colorArray[indexPath.row].1  ? .checkmark : .none
        case .max:
            cell.accessoryType = FDDisplayPreference.sharedDisplayPreferences.maxColor == self.colorArray[indexPath.row].1  ? .checkmark : .none
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.prefType {
        case .button:
            FDDisplayPreference.sharedDisplayPreferences.buttonImage = self.buttonArray[indexPath.row].1
        case .background:
            FDDisplayPreference.sharedDisplayPreferences.backgroundColor = self.colorArray[indexPath.row].1
        case .text:
            FDDisplayPreference.sharedDisplayPreferences.textColor = self.colorArray[indexPath.row].1
        case .min:
            FDDisplayPreference.sharedDisplayPreferences.minColor = self.colorArray[indexPath.row].1
        case .max:
            FDDisplayPreference.sharedDisplayPreferences.maxColor = self.colorArray[indexPath.row].1
        }
        self.navigationController?.popViewController(animated: true)
    }
}

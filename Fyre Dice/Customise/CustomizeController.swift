//
//  CustomizeController.swift
//  Fyre Dice
//
//  Created by Wayne Ohmer on 10/15/17.
//  Copyright © 2017 Wayne Ohmer. All rights reserved.
//

import UIKit

class CustomizeController: UITableViewController {

    @IBOutlet var footerView: UIView!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var buttonButton: UIButton!
    @IBOutlet weak var backgroudButton: UIButton!
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var minButton: UIButton!
    @IBOutlet weak var maxButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        FDDisplayPreference.updateApearenceIn(views: self.footerView.subviews)
        self.tableView.tableFooterView = self.footerView

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = FDDisplayPreference.sharedDisplayPreferences.backgroundColor
        self.footerView.backgroundColor = FDDisplayPreference.sharedDisplayPreferences.backgroundColor
        FDDisplayPreference.updateApearenceIn(views: self.footerView.subviews)
        self.maxLabel.textColor = FDDisplayPreference.sharedDisplayPreferences.maxColor
        self.minLabel.textColor = FDDisplayPreference.sharedDisplayPreferences.minColor
        self.buttonButton.setBackgroundImage(FDDisplayPreference.sharedDisplayPreferences.buttonImage, for: .normal)
        self.backgroudButton.backgroundColor = FDDisplayPreference.sharedDisplayPreferences.backgroundColor
        self.textButton.backgroundColor = FDDisplayPreference.sharedDisplayPreferences.textColor
        self.minButton.backgroundColor = FDDisplayPreference.sharedDisplayPreferences.minColor
        self.maxButton.backgroundColor = FDDisplayPreference.sharedDisplayPreferences.maxColor
    }
    
    @IBAction func doneTouched(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.tableView.reloadData()

        let vc = segue.destination as! FDColorSelectController
        vc.segueIdentifier = segue.identifier ?? ""
     }
 
}

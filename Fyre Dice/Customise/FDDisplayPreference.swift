//
//  FDDisplayPreference.swift
//  Fyre Dice
//
//  Created by Wayne Ohmer on 10/15/17.
//  Copyright © 2017 Wayne Ohmer. All rights reserved.
//

import UIKit

class FDDisplayPreference {
    
    static let barImageDict:[UIImage:UIImage] = [UIImage(named:"BlueButton")!:UIImage(named:"BlueBarButton")!,
                                                 UIImage(named:"PurpleButton")!:UIImage(named:"PurpleBarButton")!,
                                                 UIImage(named:"GreenButton")!:UIImage(named:"GreenBarButton")!,
                                                 UIImage(named:"RedButton")!:UIImage(named:"RedBarButton")!,
                                                 UIImage(named:"YellowButton")!:UIImage(named:"YellowBarButton")!,
                                                 UIImage(named:"GreyButton")!:UIImage(named:"GreyBarButton")!,
                                                 UIImage(named:"BrownButton")!:UIImage(named:"BrownBarButton")!]
    
    var backgroundColor = UIColor.black
    var textColor = UIColor.yellow
    var maxColor = UIColor.red
    var minColor = UIColor.green
    var buttonImage = UIImage(named:"RedButton")!
    var barButtonImage:UIImage {
        return FDDisplayPreference.barImageDict[self.buttonImage]!
    }
    
    static var sharedDisplayPreferences = FDDisplayPreference()
 
    public class func updateApearenceIn(views:[UIView]) {
        for view in views {
            if view is UIStackView {
                FDDisplayPreference.updateApearenceIn(views: view.subviews)
            } else if let button = view as? UIButton {
                if button.frame.width > button.frame.height * 3.0 {
                    button.setBackgroundImage(FDDisplayPreference.sharedDisplayPreferences.barButtonImage, for: .normal)
                } else {
                    button.setBackgroundImage(FDDisplayPreference.sharedDisplayPreferences.buttonImage, for: .normal)
                }
            } else if let label = view as? UILabel {
                label.textColor = FDDisplayPreference.sharedDisplayPreferences.textColor
            }
        }
    }
}

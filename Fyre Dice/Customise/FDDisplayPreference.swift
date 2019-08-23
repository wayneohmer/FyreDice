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
    
    //Make string dict to support standared defautls.
    static let buttonDict = ["Blue":UIImage(named:"BlueButton")!,"Purple":UIImage(named:"PurpleButton")!,"Green":UIImage(named:"GreenButton")!,"Red":UIImage(named:"RedButton")!,"Yellow":UIImage(named:"YellowButton")!,"Grey":UIImage(named:"GreyButton")!,"Brown":UIImage(named:"BrownButton")!]
    
    static let colorDict = ["Black":UIColor.black,"Blue":UIColor.blue,"Brown":UIColor.brown,"Cyan":UIColor.cyan,"Green":UIColor.green,"Magenta":UIColor.magenta,"Orange":UIColor.orange,"Purple":UIColor.purple,"Red":UIColor.red,"Yellow":UIColor.yellow,"White":UIColor.white]

    
    static var sharedDisplayPreferences = FDDisplayPreference()
    
    private func keyFor(color: UIColor) -> String? {
        for (key, dictColor) in FDDisplayPreference.colorDict {
            if color == dictColor {
                return key
            }
        }
        return nil
    }
    
    private func keyFor(button: UIImage) -> String? {
        for (key, dictButton) in FDDisplayPreference.buttonDict {
            if button == dictButton {
                return key
            }
        }
        return nil
    }
 
    public func savePreferences() {
        UserDefaults.standard.set(self.keyFor(color: backgroundColor), forKey:"backgroundColor")
        UserDefaults.standard.set(self.keyFor(color: textColor), forKey:"textColor")
        UserDefaults.standard.set(self.keyFor(color: maxColor), forKey:"maxColor")
        UserDefaults.standard.set(self.keyFor(color: minColor), forKey:"minColor")
        UserDefaults.standard.set(self.keyFor(button: buttonImage), forKey:"buttonImage")
    }
    
    public func getPreferences() {
        self.backgroundColor = FDDisplayPreference.colorDict[UserDefaults.standard.string(forKey:"backgroundColor") ?? "Black"] ?? UIColor.black
        self.textColor = FDDisplayPreference.colorDict[UserDefaults.standard.string(forKey:"textColor") ?? "Yellow"] ?? UIColor.yellow
        self.maxColor = FDDisplayPreference.colorDict[UserDefaults.standard.string(forKey:"maxColor") ?? "Red"] ?? UIColor.red
        self.minColor = FDDisplayPreference.colorDict[UserDefaults.standard.string(forKey:"minColor") ?? "Green"] ?? UIColor.green
        self.buttonImage = FDDisplayPreference.buttonDict[UserDefaults.standard.string(forKey:"buttonImage") ?? "Red"] ?? UIImage(named:"RedButton")!
    }
        
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

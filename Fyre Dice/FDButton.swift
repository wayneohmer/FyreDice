//
//  FDButton.swift
//  Fyre Dice
//
//  Created by Wayne Ohmer on 10/7/17.
//  Copyright © 2017 Wayne Ohmer. All rights reserved.
//

import UIKit

@IBDesignable
class FDButton: UIView {

    @IBInspectable
    var color:UIColor = UIColor.green
    
    @IBInspectable
    var text:String = ""
    
     override func layoutSubviews() {
        super.layoutSubviews()
        var gradientColors = [CGColor]()
        var red:CGFloat = 0, green:CGFloat = 0, blue:CGFloat = 0, alpha:CGFloat = 0

        self.color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        gradientColors.append(self.color.cgColor)
        gradientColors.append(UIColor.white.cgColor)
        
        let buttonGradient = CAGradientLayer()
        buttonGradient.frame = self.bounds
        buttonGradient.colors = gradientColors
        buttonGradient.locations = [0.0,0.6]
        self.layer.insertSublayer(buttonGradient, at: 0)

        self.layer.masksToBounds = false
        //self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 10
        
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        
    }
        
}
    
    



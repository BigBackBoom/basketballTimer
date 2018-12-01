//
//  UIColors+Util.swift
//  timer
//
//  Created by 菊池広大 on 2018/11/26.
//  Copyright © 2018 bigbackboom. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(red: UInt8, green: UInt8, blue: UInt8, alphaValue: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alphaValue
        )
    }
    
    class func timerFontColor() -> UIColor {
        return UIColor(red: 248, green: 22, blue: 16)
    }
}

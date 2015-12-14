//
//  UIColorExtensions.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 14/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//

import UIKit

extension UIColor {
    func inverse () -> UIColor {
        var r:CGFloat = 0.0
        var g:CGFloat = 0.0
        var b:CGFloat = 0.0
        var a:CGFloat = 0.0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: 1.0-r, green: 1.0 - g, blue: 1.0 - b, alpha: a)
        }
        return self
    }
    func darkColor() -> Bool{
        var r:CGFloat = 0.0
        var g:CGFloat = 0.0
        var b:CGFloat = 0.0
        var a:CGFloat = 0.0
        var colorBrightness:CGFloat = 0.0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            colorBrightness = ((r * 299) + (g * 587) + (b * 114)) / 1000
            if(colorBrightness < 0.5){
                return true
            }else{
                return false
            }
        }
        return false
    }
}
//: Playground - noun: a place where people can play

import UIKit


extension UIImage {
    func averageColor() -> UIColor {
        
        let rgba = UnsafeMutablePointer<CUnsignedChar>.alloc(4)
        let colorSpace: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!
        let info = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
        let context : CGContextRef = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, info.rawValue)!
        //let context: CGContextRef = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, info)
        
        CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage)
        
        if rgba[3] > 0 {
            
            let alpha: CGFloat = CGFloat(rgba[3]) / 255.0
            let multiplier: CGFloat = alpha / 255.0
            
            return UIColor(red: CGFloat(rgba[0]) * multiplier, green: CGFloat(rgba[1]) * multiplier, blue: CGFloat(rgba[2]) * multiplier, alpha: alpha)
            
        } else {
            
            return UIColor(red: CGFloat(rgba[0]) / 255.0, green: CGFloat(rgba[1]) / 255.0, blue: CGFloat(rgba[2]) / 255.0, alpha: CGFloat(rgba[3]) / 255.0)
        }
    }
}

var img = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://www.increasemyonlinebusiness.com/wp-content/uploads/2014/10/Google-Translate-Chrome-extension.jpg")!)!)

let color = img!.averageColor()

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




color.inverse()
color
color.darkColor()
color.similar
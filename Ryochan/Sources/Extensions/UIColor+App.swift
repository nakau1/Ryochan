//
//  Copyright(C) 2016 nakau1 All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(rgb: Int) {
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >>  8) / 255.0
        let b = CGFloat( rgb & 0x0000FF       ) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    var rgb: Int {
        var r: CGFloat = -1, g: CGFloat = -1, b: CGFloat = -1, a: CGFloat = -1
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (int(float: r) * 0x010000) + (int(float: g) * 0x000100) + int(float: b)
    }
    
    private var floatValues: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r:CGFloat = -1, g:CGFloat = -1, b:CGFloat = -1, a:CGFloat = -1
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }
    
    private func int(float: CGFloat) -> Int {
        return Int(round(float * 255.0))
    }
}

extension UIColor {
    
    var whiteness: CGFloat {
        var r: CGFloat = -1, g: CGFloat = -1, b: CGFloat = -1, a: CGFloat = -1
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (77 * r + 151 * g + 28 * b) / 255
    }
    
    var isWhiter: Bool {
        return whiteness >= 0.5
    }
}

extension UIColor {
    
    static func ==(lhs: UIColor, rhs: UIColor) -> Bool {
        return lhs.rgb == rhs.rgb
    }
}

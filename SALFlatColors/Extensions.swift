//
//  Extensions.swift
//  SALFlatColors
//
//  Created by Salvatore Petrazzuolo on 18/11/2018.
//  Copyright © 2018 A&S. All rights reserved.
//

import UIKit

extension UserDefaults {
    func sizeFor(key: String) -> CGSize? {
        var size: CGSize?
        if let sizeData = data(forKey: key) {
            size = NSKeyedUnarchiver.unarchiveObject(with: sizeData) as? CGSize
        }
        return size
    }
    func setSize(_ size: CGSize?, forKey key: String) {
        var sizeData: Data?
        if let size = size {
            sizeData = NSKeyedArchiver.archivedData(withRootObject: size)
        }
        set(sizeData, forKey: key)
    }
}

extension UIColor {
    public final func readableColor() -> UIColor {
        return isLight() ? .black : .white
    }
    
    public func isLight() -> Bool {
        let components = toRGBAComponents()
        let brightness = ((components.r * 299) + (components.g * 587) + (components.b * 114)) / 1000
        
        return brightness >= 0.5
    }
    public final func toRGBAComponents() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return (r, g, b, a)
    }
    public final var redComponent: CGFloat {
        return toRGBAComponents().r
    }
    public final var greenComponent: CGFloat {
        return toRGBAComponents().g
    }
    public final var blueComponent: CGFloat {
        return toRGBAComponents().b
    }
    public final var alphaComponent: CGFloat {
        return toRGBAComponents().a
    }
}

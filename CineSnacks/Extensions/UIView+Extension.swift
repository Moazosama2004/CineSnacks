//
//  UIView+Extension.swift
//  CineSnacks
//
//  Created by Moaz on 29/05/2026.
//


import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
}

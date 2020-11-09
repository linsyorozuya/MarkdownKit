//
//  UIFont+Traits.swift
//  Pods
//
//  Created by Ivan Bruel on 19/07/16.
//
//
import UIKit

extension UIFont {
    public func withTraits(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont? {
        guard let descriptor = fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits)) else {
            return nil
        }
        return UIFont(descriptor: descriptor, size: 0)
    }

    public func bold() -> UIFont? {
        return withTraits(.traitBold)
    }

    public func italic() -> UIFont? {
        return withTraits(.traitItalic)
    }
}

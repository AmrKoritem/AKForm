//
//  LabelStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// Used to set labels ui.
public struct LabelStyle {
    let attributes: [NSAttributedString.Key: Any]
    
    /// Initializer for `LabelStyle`.
    /// - Parameter attributes: Label text ui attributes.
    public init(attributes: [NSAttributedString.Key: Any]) {
        self.attributes = attributes
    }
    
    /// Initializer for `LabelStyle`.
    /// - Parameters:
    ///   - font: Label font.
    ///   - textColor: Label text color.
    ///   - textAlignment: Label text alignment.
    public init(
        font: UIFont = Default.Fonts.label,
        textColor: UIColor = Default.Colors.label,
        textAlignment: NSTextAlignment = .natural
    ) {
        attributes = StringAttributes.from(color: textColor, font: font, textAlignment: textAlignment)
    }
}

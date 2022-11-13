//
//  TextFieldStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// Used to set text fields ui.
public struct TextFieldStyle {
    var textColor: UIColor
    var font: UIFont
    var textAlignment: NSTextAlignment
    var placeholderStyle: PlaceholderStyle

    public init(
        textColor: UIColor,
        font: UIFont,
        textAlignment: NSTextAlignment = .natural,
        placeholderStyle: PlaceholderStyle
    ) {
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.placeholderStyle = placeholderStyle
    }
}

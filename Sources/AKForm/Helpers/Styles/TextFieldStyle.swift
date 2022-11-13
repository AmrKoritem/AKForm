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
    var backgroundColor: UIColor
    var borderStyle: FieldBorderStyle?

    public init(
        textColor: UIColor,
        font: UIFont,
        textAlignment: NSTextAlignment = .natural,
        backgroundColor: UIColor,
        borderStyle: FieldBorderStyle? = nil
    ) {
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.backgroundColor = backgroundColor
        self.borderStyle = borderStyle
    }
}

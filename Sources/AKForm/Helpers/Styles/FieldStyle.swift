//
//  FieldStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// Used to set text fields ui.
public struct FieldStyle {
    var textColor: UIColor
    var font: UIFont
    var textAlignment: NSTextAlignment
    var backgroundColor: UIColor
    var placeholderAttributes: [NSAttributedString.Key: Any]?
    var borderStyle: FieldBorderStyle

    public init(
        textColor: UIColor = Default.Colors.field,
        font: UIFont = Default.Fonts.field,
        textAlignment: NSTextAlignment = .natural,
        placeholderAttributes: [NSAttributedString.Key: Any]? = nil,
        backgroundColor: UIColor = Default.Colors.background,
        borderStyle: FieldBorderStyle = FieldBorderStyle()
    ) {
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.placeholderAttributes = placeholderAttributes
        self.backgroundColor = backgroundColor
        self.borderStyle = borderStyle
    }
}

extension NSTextAlignment {
    var buttonAlignment: UIControl.ContentHorizontalAlignment {
        switch self {
        case .left:
            return .left
        case .right:
            return .right
        default:
            return .center
        }
    }
}

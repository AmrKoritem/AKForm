//
//  FieldStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// Used to set text fields ui.
public struct FieldStyle {
    let textColor: UIColor
    let font: UIFont
    let textAlignment: NSTextAlignment
    let backgroundColor: UIColor
    let placeholderAttributes: [NSAttributedString.Key: Any]?
    let borderStyle: FieldBorderStyle

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

//
//  FieldStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public typealias IconStyleHandler = () -> (leading: IconStyle?, trailing: IconStyle?)

/// Used to determine field ui attributes.
public struct FieldStyle {
    let backgroundColor: UIColor
    let textAttributes: [NSAttributedString.Key: Any]
    let placeholderAttributes: [NSAttributedString.Key: Any]?
    let borderStyle: BorderStyle
    let shadowStyle: ShadowStyle?
    let iconStyleHandler: IconStyleHandler?
    
    /// Initializer for `FieldStyle`.
    /// - Parameters:
    ///   - font: Field data text font.
    ///   - textColor: Field data text color.
    ///   - textAlignment: Field data text alignment.
    ///   - placeholderAttributes: Field placholder ui attributes.
    ///   - backgroundColor: Field background color.
    ///   - borderStyle: Field border style.
    ///   - shadowStyle: Field shadow style.
    ///   - iconStyleHandler: Field trailing and leading icons styles.
    public init(
        font: UIFont = Default.Fonts.field,
        textColor: UIColor = Default.Colors.field,
        textAlignment: NSTextAlignment = .natural,
        placeholderAttributes: [NSAttributedString.Key: Any]? = nil,
        backgroundColor: UIColor = Default.Colors.background,
        borderStyle: BorderStyle = BorderStyle(),
        shadowStyle: ShadowStyle? = nil,
        iconStyleHandler: IconStyleHandler? = nil
    ) {
        textAttributes = StringAttributes.from(color: textColor, font: font, textAlignment: textAlignment)
        self.placeholderAttributes = placeholderAttributes
        self.backgroundColor = backgroundColor
        self.borderStyle = borderStyle
        self.shadowStyle = shadowStyle
        self.iconStyleHandler = iconStyleHandler
    }
    
    /// Initializer for `FieldStyle`.
    /// - Parameters:
    ///   - textAttributes: Field data text ui attributes.
    ///   - placeholderAttributes: Field placholder ui attributes.
    ///   - backgroundColor: Field background color.
    ///   - borderStyle: Field border style.
    ///   - shadowStyle: Field shadow style.
    ///   - iconStyleHandler: Field trailing and leading icons styles.
    public init(
        textAttributes: [NSAttributedString.Key: Any],
        placeholderAttributes: [NSAttributedString.Key: Any]? = nil,
        backgroundColor: UIColor = Default.Colors.background,
        borderStyle: BorderStyle = BorderStyle(),
        shadowStyle: ShadowStyle? = nil,
        iconStyleHandler: IconStyleHandler? = nil
    ) {
        self.textAttributes = textAttributes.isEmpty ? StringAttributes.from(
            color: Default.Colors.field,
            font: Default.Fonts.field,
            textAlignment: .natural
        ) : textAttributes
        self.placeholderAttributes = placeholderAttributes
        self.backgroundColor = backgroundColor
        self.borderStyle = borderStyle
        self.shadowStyle = shadowStyle
        self.iconStyleHandler = iconStyleHandler
    }
}

extension NSTextAlignment {
    var buttonAlignment: UIControl.ContentHorizontalAlignment {
        switch self {
        case .left:
            return .left
        case .right:
            return .right
        case .natural:
            let semanticContentAttribute = UIView.appearance().semanticContentAttribute
            let isLeft = semanticContentAttribute == .forceLeftToRight || semanticContentAttribute == .unspecified
            return isLeft ? .left : .right
        default:
            return .center
        }
    }
}

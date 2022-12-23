//
//  StringAttributes.swift
//  AKForm
//
//  Created by Amr Koritem on 24/12/2022.
//

import UIKit

struct StringAttributes {
    static let defaultLabel = [
        NSAttributedString.Key.foregroundColor: Default.Colors.label,
        NSAttributedString.Key.font: Default.Fonts.label
    ]
    static let defaultPlaceholder = [
        NSAttributedString.Key.foregroundColor: Default.Colors.placeholder,
        NSAttributedString.Key.font: Default.Fonts.placeholder
    ]
    static func from(
        color: UIColor? = nil,
        font: UIFont? = nil,
        textAlignment: NSTextAlignment? = nil
    ) -> [NSAttributedString.Key: Any] {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.font] = font
        attributes[NSAttributedString.Key.foregroundColor] = color
        if let textAlignment = textAlignment {
            attributes[NSAttributedString.Key.paragraphStyle] = NSMutableParagraphStyle().withAlignment(textAlignment)
        }
        return attributes
    }
}

extension NSMutableParagraphStyle {
    @discardableResult func withAlignment(_ textAlignment: NSTextAlignment) -> Self {
        alignment = textAlignment
        return self
    }
}

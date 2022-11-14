//
//  LabelStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// Used to set labels ui.
public struct LabelStyle {
    var text: String?
    var textColor: UIColor = Default.Colors.label
    var font: UIFont = Default.Fonts.label
    var attributedText: NSAttributedString?
    var textAlignment: NSTextAlignment

    public init(attributedText: NSAttributedString, textAlignment: NSTextAlignment = .natural) {
        self.attributedText = attributedText
        self.textAlignment = textAlignment
    }

    public init(
        text: String,
        textColor: UIColor = Default.Colors.label,
        font: UIFont = Default.Fonts.label,
        textAlignment: NSTextAlignment = .natural
    ) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
    }
}

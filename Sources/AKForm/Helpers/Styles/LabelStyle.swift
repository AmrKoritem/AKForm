//
//  LabelStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// Used to set labels ui.
public struct LabelStyle {
    let text: String?
    let textColor: UIColor
    let font: UIFont
    let attributedText: NSAttributedString?
    let textAlignment: NSTextAlignment

    public init(attributedText: NSAttributedString, textAlignment: NSTextAlignment = .natural) {
        text = nil
        textColor = Default.Colors.label
        font = Default.Fonts.label
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
        attributedText = nil
        self.textAlignment = textAlignment
    }
}

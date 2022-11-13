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
    var textColor: UIColor
    var font: UIFont
    var attributedText: NSAttributedString?
    var textAlignment: NSTextAlignment

    public init(attributedText: NSAttributedString, textAlignment: NSTextAlignment = .natural) {
        textColor = .black
        font = .systemFont(ofSize: 1)
        self.attributedText = attributedText
        self.textAlignment = textAlignment
    }

    public init(text: String, textColor: UIColor, font: UIFont, textAlignment: NSTextAlignment = .natural) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
    }
}

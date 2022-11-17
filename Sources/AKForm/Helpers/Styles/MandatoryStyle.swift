//
//  MandatoryStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 17/11/2022.
//

import UIKit

public struct MandatoryStyle {
    public enum SymbolPosition {
        case start
        case end
    }

    let isMandatory: Bool
    let symbol: String
    let color: UIColor
    let font: UIFont
    let position: SymbolPosition

    var attributedString: NSAttributedString {
        NSAttributedString(
            string: symbol,
            attributes: [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: color
            ]
        )
    }

    public init(
        isMandatory: Bool = false,
        symbol: String = "*",
        color: UIColor = Default.Colors.mandatory,
        font: UIFont = Default.Fonts.mandatory,
        position: SymbolPosition = .end
    ) {
        self.isMandatory = isMandatory
        self.symbol = symbol
        self.color = color
        self.font = font
        self.position = position
    }

    public func addSymbol(to text: NSMutableAttributedString) {
        switch position {
        case .start:
            text.insert(attributedString, at: 0)
        case .end:
            text.append(attributedString)
        }
    }
}

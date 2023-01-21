//
//  MandatoryStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 17/11/2022.
//

import UIKit

/// Determine symbol position based on its context.
public enum SymbolPosition {
    /// start of context.
    case start
    /// end of context.
    case end
    /// end of screen on the line of context.
    case lineEnd(endMargin: CGFloat)
}

/// Determine style of mandatory symbol.
public struct MandatoryStyle {
    let isMandatory: Bool
    let symbol: String
    let color: UIColor
    let font: UIFont
    /// For this property, .end and .lineEnd yield the same result.
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
    
    /// Initializer for `MandatoryStyle`.
    /// - Parameters:
    ///   - isMandatory: If true, then the symbol should be hidden and validation of data is to be tolerant.
    ///   - symbol: Symbol used as indicator for the field being mandatory.
    ///   - color: Symbol color.
    ///   - font: Symbol font.
    ///   - position: Symbol position.
    public init(
        isMandatory: Bool = Default.isMandatory,
        symbol: String = Default.Strings.mandatorySymbol,
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

    /// Adds the symbol to an attributed string.
    public func addSymbol(to text: NSMutableAttributedString) {
        switch position {
        case .start:
            text.insert(attributedString, at: 0)
        case .end, .lineEnd:
            text.append(attributedString)
        }
    }
}

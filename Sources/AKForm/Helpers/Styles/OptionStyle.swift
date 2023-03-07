//
//  OptionStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// Determine a sheet option ui attributes.
public struct OptionStyle {
    /// Determine selected option ui attributes.
    public enum SelectionStyle {
        case none
        case backgroundColor(color: UIColor)
        case labelColor(color: UIColor)
        case symbol(image: UIImage?, position: SymbolPosition)
        case custom(styles: [SelectionStyle])
    }

    let titleColor: UIColor
    let titleFont: UIFont
    let titleTextAlignment: NSTextAlignment
    let subtitleColor: UIColor
    let subtitleFont: UIFont
    let subtitleTextAlignment: NSTextAlignment
    let backgroundColor: UIColor
    let separatorStyle: SeparatorStyle
    let selectionStyle: SelectionStyle
    
    /// Initializer for `OptionStyle`.
    /// - Parameters:
    ///   - titleColor: Option title color.
    ///   - titleFont: Option title font.
    ///   - titleTextAlignment: Option title text alignment.
    ///   - subtitleColor: Option subtitle color.
    ///   - subtitleFont: Option subtitle font.
    ///   - subtitleTextAlignment: Option subtitle text alignment.
    ///   - backgroundColor: Option background color.
    ///   - separatorStyle: Option separator style.
    ///   - selectionStyle: Option selection style.
    public init(
        titleColor: UIColor = Default.Colors.optionTitle,
        titleFont: UIFont = Default.Fonts.optionTitle,
        titleTextAlignment: NSTextAlignment = .natural,
        subtitleColor: UIColor = Default.Colors.optionSubtitle,
        subtitleFont: UIFont = Default.Fonts.optionSubtitle,
        subtitleTextAlignment: NSTextAlignment = .natural,
        backgroundColor: UIColor = Default.Colors.optionBackground,
        separatorStyle: SeparatorStyle = SeparatorStyle(),
        selectionStyle: SelectionStyle = Default.optionSelectionStyle
    ) {
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.titleTextAlignment = titleTextAlignment
        self.subtitleColor = subtitleColor
        self.subtitleFont = subtitleFont
        self.subtitleTextAlignment = subtitleTextAlignment
        self.backgroundColor = backgroundColor
        self.separatorStyle = separatorStyle
        self.selectionStyle = selectionStyle
    }
}

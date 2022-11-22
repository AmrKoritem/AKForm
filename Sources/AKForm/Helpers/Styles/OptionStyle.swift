//
//  OptionStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public struct OptionStyle {
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

    public init(
        titleColor: UIColor = Default.Colors.optionTitle,
        titleFont: UIFont = Default.Fonts.optionTitle,
        titleTextAlignment: NSTextAlignment = .natural,
        subtitleColor: UIColor = Default.Colors.optionSubtitle,
        subtitleFont: UIFont = Default.Fonts.optionSubtitle,
        subtitleTextAlignment: NSTextAlignment = .natural,
        backgroundColor: UIColor = Default.Colors.optionBackground,
        separatorStyle: SeparatorStyle = SeparatorStyle(),
        selectionStyle: SelectionStyle = .none
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

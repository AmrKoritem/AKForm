//
//  OptionStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public struct OptionStyle {
    let textColor: UIColor
    let font: UIFont
    let textAlignment: NSTextAlignment
    let backgroundColor: UIColor
    let separatorStyle: SeparatorStyle

    public init(
        textColor: UIColor = Default.Colors.optionTitle,
        font: UIFont = Default.Fonts.optionTitle,
        textAlignment: NSTextAlignment = .natural,
        backgroundColor: UIColor = Default.Colors.optionBackground,
        separatorStyle: SeparatorStyle = SeparatorStyle()
    ) {
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.backgroundColor = backgroundColor
        self.separatorStyle = separatorStyle
    }
}

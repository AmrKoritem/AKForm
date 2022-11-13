//
//  OptionStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public struct OptionStyle {
    public static let defaultTextColor: UIColor = .black
    public static let defaultFont: UIFont = .systemFont(ofSize: 16)
    public static let defaultBackgroundColor: UIColor = .clear

    var textColor: UIColor
    var font: UIFont
    var textAlignment: NSTextAlignment
    var backgroundColor: UIColor
    var separatorStyle: SeparatorStyle

    public init(
        textColor: UIColor = OptionStyle.defaultTextColor,
        font: UIFont = OptionStyle.defaultFont,
        textAlignment: NSTextAlignment = .natural,
        backgroundColor: UIColor = OptionStyle.defaultBackgroundColor,
        separatorStyle: SeparatorStyle = SeparatorStyle()
    ) {
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.backgroundColor = backgroundColor
        self.separatorStyle = separatorStyle
    }
}

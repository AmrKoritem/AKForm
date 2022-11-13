//
//  UILabel+Extension.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public extension UILabel {
    /// Set label attributes using a `LabelStyle` object.
    func setStyle(with labelStyle: LabelStyle) {
        textColor = labelStyle.textColor
        font = labelStyle.font
        textAlignment = labelStyle.textAlignment
        text = labelStyle.text
        guard let attributedText = labelStyle.attributedText else { return }
        self.attributedText = attributedText
    }
}

//
//  UILabel+Extension.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public extension UILabel {
    /// Set label attributes using `LabelStyle` and `MandatoryStyle` objects.
    func setStyle(with labelStyle: LabelStyle, mandatory: MandatoryStyle = MandatoryStyle()) {
        textAlignment = labelStyle.textAlignment
        guard let attributedText = labelStyle.attributedText else {
            let attributedText = NSMutableAttributedString(
                string: labelStyle.text ?? "",
                attributes: [
                    NSAttributedString.Key.font: labelStyle.font,
                    NSAttributedString.Key.foregroundColor: labelStyle.textColor
                ])
            mandatory.addSymbol(to: attributedText)
            self.attributedText = attributedText
            return
        }
        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
        mandatory.addSymbol(to: mutableAttributedText)
        self.attributedText = mutableAttributedText
    }
}

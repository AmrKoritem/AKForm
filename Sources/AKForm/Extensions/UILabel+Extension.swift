//
//  UILabel+Extension.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public extension UILabel {
    /// Set label attributes using `LabelStyle` and `MandatoryStyle` objects.
    func setStyle(with labelStyle: LabelStyle, mandatoryStyle: MandatoryStyle = MandatoryStyle()) {
        let mutableAttributedText = NSMutableAttributedString(attributedString: setStyle(with: labelStyle))
        if mandatoryStyle.isMandatory {
            mandatoryStyle.addSymbol(to: mutableAttributedText)
        }
        self.attributedText = mutableAttributedText
    }

    /// Set label attributes using `LabelStyle` object.
    @discardableResult func setStyle(with labelStyle: LabelStyle) -> NSAttributedString {
        textAlignment = labelStyle.textAlignment
        guard let attributedText = labelStyle.attributedText else {
            let attributedText = NSAttributedString(
                string: labelStyle.text ?? "",
                attributes: Default.StringAttributes.from(color: labelStyle.textColor, font: labelStyle.font)
            )
            self.attributedText = attributedText
            return attributedText
        }
        self.attributedText = attributedText
        sizeToFit()
        return attributedText
    }
}

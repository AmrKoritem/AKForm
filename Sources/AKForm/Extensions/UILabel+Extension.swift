//
//  UILabel+Extension.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public extension UILabel {
    /// Set label attributes using `MandatoryStyle` objects.
    func setStyle(with mandatoryStyle: MandatoryStyle = MandatoryStyle()) {
        guard let attributedText = attributedText else { return }
        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
        if mandatoryStyle.isMandatory {
            mandatoryStyle.addSymbol(to: mutableAttributedText)
        }
        self.attributedText = mutableAttributedText
    }
}

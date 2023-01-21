//
//  UIButton+Extension.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public extension UIButton {
    /// Set button ui attributes using a text and a `FieldStyle` object.
    func setStyle(with text: String?, andStyle fieldStyle: FieldStyle) {
        let attrText = NSAttributedString(string: text ?? "", attributes: fieldStyle.textAttributes)
        setAttributedTitle(attrText, for: .normal)
        let textAlignment = fieldStyle.textAttributes.textAlignment ?? .natural
        contentHorizontalAlignment = textAlignment.buttonAlignment
        backgroundColor = fieldStyle.backgroundColor
        stroked(with: fieldStyle.borderStyle)
        guard let shadowStyle = fieldStyle.shadowStyle else { return }
        shadowed(with: shadowStyle)
    }
}

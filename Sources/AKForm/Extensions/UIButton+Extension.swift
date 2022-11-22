//
//  UIButton+Extension.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public extension UIButton {
    /// Set button ui attributes using a `FieldStyle` object.
    func setStyle(with fieldStyle: FieldStyle) {
        setTitleColor(fieldStyle.textColor, for: .normal)
        titleLabel?.font = fieldStyle.font
        contentHorizontalAlignment = fieldStyle.textAlignment.buttonAlignment
        backgroundColor = fieldStyle.backgroundColor
        stroked(with: fieldStyle.borderStyle)
        guard let shadowStyle = fieldStyle.shadowStyle else { return }
        shadowed(with: shadowStyle)
    }
}

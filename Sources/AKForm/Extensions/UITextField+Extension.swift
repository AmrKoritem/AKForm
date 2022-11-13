//
//  UITextField+Extension.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public extension UITextField {
    /// Set text field attributes using a `TextFieldStyle` object.
    func setStyle(with textFieldStyle: TextFieldStyle) {
        textColor = textFieldStyle.textColor
        font = textFieldStyle.font
        textAlignment = textFieldStyle.textAlignment
        placeholder = textFieldStyle.placeholderStyle.text
        guard let attributedText = textFieldStyle.placeholderStyle.attributedText else { return }
        attributedPlaceholder = attributedText
    }

    /// Set text field typing attributes using a `FieldContentType` object.
    func setTypingAttributes(with contentType: FieldContentType) {
        keyboardType = contentType.keyboardType
        autocapitalizationType = contentType.autocapitalizationType
        autocorrectionType = contentType.autocorrectionType
        textContentType = contentType.contentType
        isSecureTextEntry = contentType.isSecureTextEntry
    }
}

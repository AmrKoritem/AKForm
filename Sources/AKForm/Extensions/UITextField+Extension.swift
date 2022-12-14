//
//  UITextField+Extension.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public extension UITextField {
    var leftPadding: CGFloat {
        get {
            leftView?.frame.size.width ?? 0
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    var rightPadding: CGFloat {
        get {
            rightView?.frame.size.width ?? 0
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }

    func setHorizontalPadding(to padding: CGFloat) {
        leftPadding = padding
        rightPadding = padding
    }

    /// Set text field attributes using a `FieldStyle` object.
    func setStyle(with fieldStyle: FieldStyle) {
        textColor = fieldStyle.textColor
        font = fieldStyle.font
        textAlignment = fieldStyle.textAlignment
        backgroundColor = fieldStyle.backgroundColor
        stroked(with: fieldStyle.borderStyle)
        guard let shadowStyle = fieldStyle.shadowStyle else { return }
        shadowed(with: shadowStyle)
    }

    func setStyle(with textFieldStyle: SheetStyle.TextFieldStyle) {
        placeholder = textFieldStyle.placeholder
        setStyle(with: textFieldStyle.fieldStyle)
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

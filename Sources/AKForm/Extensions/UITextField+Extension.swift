//
//  UITextField+Extension.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public extension UITextField {
    /// Set text field attributes using a `FieldStyle` object.
    func setStyle(with textFieldStyle: FieldStyle) {
        textColor = textFieldStyle.textColor
        font = textFieldStyle.font
        textAlignment = textFieldStyle.textAlignment
        backgroundColor = textFieldStyle.backgroundColor
    }

    /// Set text field typing attributes using a `FieldContentType` object.
    func setTypingAttributes(with contentType: FieldContentType) {
        keyboardType = contentType.keyboardType
        autocapitalizationType = contentType.autocapitalizationType
        autocorrectionType = contentType.autocorrectionType
        textContentType = contentType.contentType
        isSecureTextEntry = contentType.isSecureTextEntry
    }

    var leftPadding: CGFloat {
        get {
            return leftView?.frame.size.width ?? 0
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    var rightPadding: CGFloat {
        get {
            return rightView?.frame.size.width ?? 0
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
}

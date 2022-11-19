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

    func setLeftIcon(with iconStyle: IconStyle) {
        self.leftView = iconStyle.getIconContainerView(width: 21, height: frame.size.height)
        self.leftViewMode = .always
    }

    func setRightIcon(with iconStyle: IconStyle) {
        self.rightView = iconStyle.getIconContainerView(width: 21, height: frame.size.height)
        self.rightViewMode = .always
    }
}

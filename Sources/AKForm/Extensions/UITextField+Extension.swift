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
    func setStyle(with textFieldStyle: FieldStyle) {
        textColor = textFieldStyle.textColor
        font = textFieldStyle.font
        textAlignment = textFieldStyle.textAlignment
        backgroundColor = textFieldStyle.backgroundColor
    }

    func setStyle(with textFieldStyle: SheetStyle.TextFieldStyle) {
        placeholder = textFieldStyle.placeholder
        setStyle(with: textFieldStyle.fieldStyle)
        setBorder(with: textFieldStyle.fieldStyle.borderStyle)
        guard let iconStyleHandler = textFieldStyle.fieldStyle.iconStyleHandler else { return }
        setIcons(with: iconStyleHandler)
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
        leftView = iconStyle.getIconContainerView(iconViewSize: CGSize(width: 21, height: frame.size.height), isLeft: true)
        leftViewMode = .always
    }

    func setRightIcon(with iconStyle: IconStyle) {
        rightView = iconStyle.getIconContainerView(iconViewSize: CGSize(width: 21, height: frame.size.height), isLeft: false)
        rightViewMode = .always
    }

    func setIcons(with iconStyleHandler: IconStyleHandler) {
        if let leadingIcon = iconStyleHandler().leading {
            setLeftIcon(with: leadingIcon)
        }
        if let trailingIcon = iconStyleHandler().trailing {
            setRightIcon(with: trailingIcon)
        }
    }
}

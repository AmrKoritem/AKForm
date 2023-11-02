//
//  UITextField+Extension.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public extension UITextField {
    var selectedTextPosition: Range<String.Index>? {
        guard let text = text, let range = selectedTextRange else { return nil }
        let startIndex = offset(from: beginningOfDocument, to: range.start)
        let endIndex = offset(from: beginningOfDocument, to: range.end)
        return Range(NSRange(location: startIndex, length: endIndex - startIndex), in: text)
    }

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

    /// Set text field attributes using a text and a `FieldStyle` object.
    func setStyle(with text: String?, andStyle fieldStyle: FieldStyle) {
        attributedText = NSAttributedString(string: text ?? "", attributes: fieldStyle.textAttributes)
        textColor = fieldStyle.textAttributes[.foregroundColor] as? UIColor
        backgroundColor = fieldStyle.backgroundColor
        textAlignment = fieldStyle.textAttributes.textAlignment ?? .natural
        stroked(with: fieldStyle.borderStyle)
        guard let shadowStyle = fieldStyle.shadowStyle else { return }
        shadowed(with: shadowStyle)
    }

    func setStyle(with textFieldStyle: SheetStyle.TextFieldStyle) {
        attributedPlaceholder = NSAttributedString(
            string: textFieldStyle.placeholder ?? "",
            attributes: textFieldStyle.fieldStyle.placeholderAttributes)
    }

    /// Set text field typing attributes using a `FieldContentType` object.
    func setTypingAttributes(with contentType: Field.ContentType) {
        keyboardType = contentType.keyboardType
        autocapitalizationType = contentType.autocapitalizationType
        autocorrectionType = contentType.autocorrectionType
        textContentType = contentType.contentType
        isSecureTextEntry = contentType.isSecureTextEntry
    }
}

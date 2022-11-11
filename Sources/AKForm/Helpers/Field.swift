//
//  Field.swift
//  AKForm
//
//  Created by Amr Koritem on 10/11/2022.
//

import UIKit

/// Field properties wrapper.
public struct Field {
    var id: Int
    var count: FieldCount
    var type: FieldType
    var contentType: FieldContentType
    var labelStyle: LabelStyle
    var textFieldStyle: TextFieldStyle
    var emptyErrorMessage: String?
    var invalidErrorMessage: String?
    var textFieldEditingHandler: TextFieldEditingChangedHandler?
    var textFieldEditingDidEndHandler: TextFieldEditingDidEnddHandler?

    public init(
        id: Int,
        count: FieldCount,
        type: FieldType,
        contentType: FieldContentType,
        labelStyle: LabelStyle,
        textFieldStyle: TextFieldStyle,
        emptyErrorMessage: String? = nil,
        invalidErrorMessage: String? = nil,
        textFieldEditingHandler: TextFieldEditingChangedHandler? = nil,
        textFieldEditingDidEndHandler: TextFieldEditingDidEnddHandler? = nil
    ) {
        self.id = id
        self.count = count
        self.type = type
        self.contentType = contentType
        self.labelStyle = labelStyle
        self.textFieldStyle = textFieldStyle
        self.emptyErrorMessage = emptyErrorMessage
        self.invalidErrorMessage = invalidErrorMessage
        self.textFieldEditingHandler = textFieldEditingHandler
        self.textFieldEditingDidEndHandler = textFieldEditingDidEndHandler
    }
}

public extension UITextField {
    func setStyle(with textFieldStyle: TextFieldStyle) {
        textColor = textFieldStyle.textColor
        font = textFieldStyle.font
        textAlignment = textFieldStyle.textAlignment
        placeholder = textFieldStyle.placeholderStyle.text
        attributedPlaceholder = textFieldStyle.placeholderStyle.attributedText
    }

    func setTypingAttributes(with contentType: FieldContentType) {
        keyboardType = contentType.keyboardType
        autocapitalizationType = contentType.autocapitalizationType
        autocorrectionType = contentType.autocorrectionType
        textContentType = contentType.contentType
        isSecureTextEntry = contentType.isSecureTextEntry
    }
}

/// Supported field count.
public enum FieldCount: Int {
    case uni = 1
    case bi = 2
}

/// Supported field types.
public enum FieldType {
    case text
    case dropDown
    case filePicker
    case sheet
    case location
    case picker
}

/// Supported field content types.
public enum FieldContentType {
    case name
    case email
    case password
    case image
    case price
    case other

    /// Validation equivalent regex.
    var validationRegex: String.ValidationRegex {
        switch self {
        case .name:
            return .name
        case .email:
            return .email
        case .password:
            return .password
        default:
            return .none
        }
    }
}

public extension FieldContentType {
    /// Keyboard type.
    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        case .price:
            return .decimalPad
        default:
            return .default
        }
    }

    /// Auto-capitalization type.
    var autocapitalizationType: UITextAutocapitalizationType {
        switch self {
        case .other:
            return .sentences
        case .name:
            return .words
        default:
            return .none
        }
    }

    /// Auto-correction type.
    var autocorrectionType: UITextAutocorrectionType {
        switch self {
        case .other:
            return .default
        default:
            return .no
        }
    }

    /// Field Content type.
    var contentType: UITextContentType? {
        switch self {
        case .name:
            return .name
        case .email:
            return .emailAddress
        case .password:
            return .password
        default:
            return nil
        }
    }

    /// Determines if the text input should be shown.
    var isSecureTextEntry: Bool {
        switch self {
        case .password:
            return true
        default:
            return false
        }
    }
}

public struct LabelStyle {
    var text: String?
    var textColor: UIColor
    var font: UIFont
    var attributedText: NSAttributedString?
    var textAlignment: NSTextAlignment

    public init(attributedText: NSAttributedString, textAlignment: NSTextAlignment = .natural) {
        textColor = .black
        font = .systemFont(ofSize: 1)
        self.attributedText = attributedText
        self.textAlignment = textAlignment
    }

    public init(text: String, textColor: UIColor, font: UIFont, textAlignment: NSTextAlignment = .natural) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
    }
}

public struct PlaceholderStyle {
    var text: String?
    var attributedText: NSAttributedString?

    public init(attributedText: NSAttributedString) {
        self.attributedText = attributedText
    }

    public init(text: String) {
        self.text = text
    }
}

public struct TextFieldStyle {
    var textColor: UIColor
    var font: UIFont
    var textAlignment: NSTextAlignment
    var placeholderStyle: PlaceholderStyle

    public init(
        textColor: UIColor,
        font: UIFont,
        textAlignment: NSTextAlignment = .natural,
        placeholderStyle: PlaceholderStyle
    ) {
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.placeholderStyle = placeholderStyle
    }
}

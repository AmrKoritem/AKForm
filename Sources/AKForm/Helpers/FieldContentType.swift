//
//  FieldContentType.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public typealias ContentTypeAttributes = (
    keyboardType: UIKeyboardType?,
    autocapitalizationType: UITextAutocapitalizationType?,
    autocorrectionType: UITextAutocorrectionType?,
    contentType: UITextContentType?,
    isSecureTextEntry: Bool?,
    validationHandler: ((String?) -> String.ValidationStatus)?
)

/// Supported field content types.
public enum FieldContentType {
    case name
    case email
    case password(isSecureTextEntry: Bool? = nil)
    case image
    case price
    case phone
    case address
    case url
    case other
    case custom(contentTypeAttributes: ContentTypeAttributes)

    /// Validation equivalent regex.
    var validationRegex: String.ValidationRegex {
        switch self {
        case .name:
            return .name
        case .email:
            return .email
        case .password:
            return .password
        case .url:
            return .url
        default:
            return .none
        }
    }

    func getValidationStatus(for text: String?) -> String.ValidationStatus? {
        switch self {
        case .custom(let contentTypeAttributes):
            return contentTypeAttributes.validationHandler?(text)
        default:
            return text?.getValidationStatus(for: validationRegex)
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
        case .phone:
            return .phonePad
        case .url:
            return .URL
        case .custom(let contentTypeAttributes):
            return contentTypeAttributes.keyboardType ?? .default
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
        case .custom(let contentTypeAttributes):
            return contentTypeAttributes.autocapitalizationType ?? .none
        default:
            return .none
        }
    }

    /// Auto-correction type.
    var autocorrectionType: UITextAutocorrectionType {
        switch self {
        case .other:
            return .default
        case .custom(let contentTypeAttributes):
            return contentTypeAttributes.autocorrectionType ?? .no
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
        case .address:
            return .fullStreetAddress
        case .url:
            return .URL
        case .custom(let contentTypeAttributes):
            return contentTypeAttributes.contentType
        default:
            return nil
        }
    }

    /// Determines if the text input should be shown.
    var isSecureTextEntry: Bool {
        switch self {
        case .password(let isSecureTextEntry):
            return isSecureTextEntry ?? true
        case .custom(let contentTypeAttributes):
            return contentTypeAttributes.isSecureTextEntry ?? false
        default:
            return false
        }
    }
}

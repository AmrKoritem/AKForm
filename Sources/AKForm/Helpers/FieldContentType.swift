//
//  FieldContentType.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

extension Field {
    /// Field keyboard attributes.
    public typealias KeyboardAttributes = (
        keyboardType: UIKeyboardType?,
        autocapitalizationType: UITextAutocapitalizationType?,
        autocorrectionType: UITextAutocorrectionType?
    )

    /// Field security attributes.
    public typealias SecurityAttributes = (
        contentType: UITextContentType?,
        isSecureTextEntry: Bool?
    )

    /// Field validation handler.
    public typealias ValidationHandler = (String?) -> String.ValidationStatus

    /// Supported field content types.
    public enum ContentType {
        case name
        case email
        case password(isSecureTextEntry: Bool? = nil)
        case confirmPassword(passwordFieldId: Int, isSecureTextEntry: Bool? = nil)
        case image
        case price
        case phone
        case address
        case url
        case other
        case custom(
            keyboardAttributes: KeyboardAttributes,
            securityAttributes: SecurityAttributes,
            validationHandler: ValidationHandler?
        )

        /// Validation equivalent regex.
        var validationRegex: String.ValidationRegex {
            switch self {
            case .name:
                return .name
            case .email:
                return .email
            case .password, .confirmPassword:
                return .password
            case .url:
                return .url
            case .phone:
                return .phone
            default:
                return .none
            }
        }

        func getValidationStatus(for text: String?) -> String.ValidationStatus? {
            switch self {
            case .custom(_, _, let validationHandler):
                return validationHandler?(text)
            default:
                return text?.getValidationStatus(for: validationRegex)
            }
        }
    }
}

public extension Field.ContentType {
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
        case .custom(let keyboardAttributes, _, _):
            return keyboardAttributes.keyboardType ?? .default
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
        case .custom(let keyboardAttributes, _, _):
            return keyboardAttributes.autocapitalizationType ?? .none
        default:
            return .none
        }
    }

    /// Auto-correction type.
    var autocorrectionType: UITextAutocorrectionType {
        switch self {
        case .other:
            return .default
        case .custom(let keyboardAttributes, _, _):
            return keyboardAttributes.autocorrectionType ?? .no
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
        case .password, .confirmPassword:
            return .password
        case .address:
            return .fullStreetAddress
        case .url:
            return .URL
        case .custom(_, let securityAttributes, _):
            return securityAttributes.contentType
        default:
            return nil
        }
    }

    /// Determines if the text input should be shown.
    var isSecureTextEntry: Bool {
        switch self {
        case .password(let isSecureTextEntry), .confirmPassword(_, let isSecureTextEntry):
            return isSecureTextEntry ?? true
        case .custom(_, let securityAttributes, _):
            return securityAttributes.isSecureTextEntry ?? false
        default:
            return false
        }
    }
}

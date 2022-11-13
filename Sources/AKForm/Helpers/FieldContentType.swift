//
//  FieldContentType.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// Supported field content types.
public enum FieldContentType {
    case name
    case email
    case password
    case image
    case price
    case phone
    case address
    case url
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
        case .url:
            return .url
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
        case .phone:
            return .phonePad
        case .url:
            return .URL
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
        case .address:
            return .fullStreetAddress
        case .url:
            return .URL
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

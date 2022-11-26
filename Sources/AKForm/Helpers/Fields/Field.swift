//
//  Field.swift
//  AKForm
//
//  Created by Amr Koritem on 10/11/2022.
//

import UIKit

/// Supported field count.
public enum FieldCount: Int {
    case uni = 1
    // TODO: - double fields
//    case bi = 2
}

/// Supported field types.
public enum FieldType {
    case text
    case sheet
    // TODO: - other field types
//    case dropDown
//    case filePicker
//    case location
//    case picker
}

public typealias OnFirstResponderStyle = () -> (
    labelStyle: LabelStyle?,
    fieldStyle: FieldStyle?,
    mandatoryStyle: MandatoryStyle?
)
public typealias ValidationHandler = (String?) -> String.ValidationStatus

/// Field properties wrapper.
public class Field {
    let id: Int
    let count: FieldCount
    let type: FieldType
    let contentType: FieldContentType
    let labelStyle: LabelStyle
    let fieldStyle: FieldStyle
    let placeholder: String
    let errorMessages: FieldErrorMessages
    let mandatoryStyle: MandatoryStyle
    var onFirstResponderStyle: OnFirstResponderStyle?
    var validationHandler: ValidationHandler?

    init(
        id: Int,
        count: FieldCount = .uni,
        type: FieldType,
        contentType: FieldContentType,
        labelStyle: LabelStyle,
        fieldStyle: FieldStyle,
        placeholder: String,
        errorMessages: FieldErrorMessages?,
        mandatoryStyle: MandatoryStyle,
        onFirstResponderStyle: OnFirstResponderStyle?,
        validationHandler: ValidationHandler?
    ) {
        self.id = id
        self.count = count
        self.type = type
        self.contentType = contentType
        self.labelStyle = labelStyle
        self.fieldStyle = fieldStyle
        self.placeholder = placeholder
        self.errorMessages = errorMessages ?? {
            switch contentType {
            case .confirmPassword(_, _):
                return FieldErrorMessages(
                    empty: "Please enter your password",
                    invalid: "Must be the same as the password"
                )
            default:
                return FieldErrorMessages(
                    empty: Default.Strings.errorMessageEmpty,
                    invalid: Default.Strings.errorMessageInvalid
                )
            }
        }()
        self.mandatoryStyle = mandatoryStyle
        self.onFirstResponderStyle = onFirstResponderStyle
        self.validationHandler = validationHandler
    }

    public func getOnFirstResponderCopy() -> Field {
        Field(
            id: id,
            count: count,
            type: type,
            contentType: contentType,
            labelStyle: onFirstResponderStyle?().labelStyle ?? labelStyle,
            fieldStyle: onFirstResponderStyle?().fieldStyle ?? fieldStyle,
            placeholder: placeholder,
            errorMessages: errorMessages,
            mandatoryStyle: onFirstResponderStyle?().mandatoryStyle ?? mandatoryStyle,
            onFirstResponderStyle: onFirstResponderStyle,
            validationHandler: validationHandler
        )
    }
}

public extension Collection where Iterator.Element == Field {
    /// Returns an array of elements with the specified id.
    func first(withId id: Int) -> Element? {
        filter { $0.id == id }.first
    }
}

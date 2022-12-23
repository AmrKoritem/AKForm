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
    let contentType: ContentType
    let labelStyle: LabelStyle
    let fieldStyle: FieldStyle
    let texts: Texts
    let mandatoryStyle: MandatoryStyle
    var onFirstResponderStyle: OnFirstResponderStyle?
    var validationHandler: ValidationHandler?

    init(
        id: Int,
        count: FieldCount = .uni,
        type: FieldType,
        contentType: ContentType,
        labelStyle: LabelStyle,
        fieldStyle: FieldStyle,
        texts: Texts,
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
        self.texts = texts
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
            texts: texts,
            mandatoryStyle: onFirstResponderStyle?().mandatoryStyle ?? mandatoryStyle,
            onFirstResponderStyle: onFirstResponderStyle,
            validationHandler: validationHandler
        )
    }

    public func validate(data: String?) -> String.ValidationStatus {
        guard mandatoryStyle.isMandatory == true || data?.isEmpty == false else { return .valid }
        let validationStatus = validationHandler?(data) ?? contentType.getValidationStatus(for: data) ?? .valid
        return validationStatus
    }

    public func validateConfirmPassword(_ confirmPasswordData: String?, passwordData: String?) -> String.ValidationStatus {
        guard mandatoryStyle.isMandatory == true || confirmPasswordData?.isEmpty == false else { return .valid }
        let validationStatus = validationHandler?(confirmPasswordData) ?? {
            if confirmPasswordData?.isEmpty != false {
                return String.ValidationStatus.missing
            } else if passwordData != confirmPasswordData {
                return String.ValidationStatus.invalid
            } else {
                return String.ValidationStatus.valid
            }
        }()
        return validationStatus
    }
}

public extension Collection where Iterator.Element == Field {
    /// Returns an array of elements with the specified id.
    func first(withId id: Int) -> Element? {
        filter { $0.id == id }.first
    }
}

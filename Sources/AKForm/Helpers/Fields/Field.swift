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

/// Styles to be used when the field content is being changed.
public typealias FirstResponderStyle = () -> (
    labelStyle: LabelStyle?,
    fieldStyle: FieldStyle?,
    mandatoryStyle: MandatoryStyle?
)

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
    var firstResponderStyle: FirstResponderStyle?
    var validationHandler: ValidationHandler?

    /// A new `Field` object with the `onFirstResponder` styles replacing the field styles.
    public var firstResponderCopy: Field {
        Field(
            id: id,
            count: count,
            type: type,
            contentType: contentType,
            labelStyle: firstResponderStyle?().labelStyle ?? labelStyle,
            fieldStyle: firstResponderStyle?().fieldStyle ?? fieldStyle,
            texts: texts,
            mandatoryStyle: firstResponderStyle?().mandatoryStyle ?? mandatoryStyle,
            firstResponderStyle: firstResponderStyle,
            validationHandler: validationHandler
        )
    }
    
    /// Initializer for `Field`.
    /// - Parameters:
    ///   - id: Field id.
    ///   - count: Field data instances count.
    ///   - type: Field type.
    ///   - contentType: Field data type.
    ///   - labelStyle: Field title style.
    ///   - fieldStyle: Field ui attributes.
    ///   - texts: Field fixed texts like title, placeholder, etc.
    ///   - mandatoryStyle: Field mandatory symbol properties.
    ///   - firstResponderStyle: Field style when it's the first responder.
    ///   - validationHandler: Field validation action handlers.
    init(
        id: Int,
        count: FieldCount,
        type: FieldType,
        contentType: ContentType,
        labelStyle: LabelStyle,
        fieldStyle: FieldStyle,
        texts: Texts,
        mandatoryStyle: MandatoryStyle,
        firstResponderStyle: FirstResponderStyle?,
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
        self.firstResponderStyle = firstResponderStyle
        self.validationHandler = validationHandler
    }
    
    /// Determines the validation status of the field considering its mandatory status.
    /// This method uses the custom validation handler if provided. If not, it uses the default validation handler.
    /// - Parameter data: Data to be validated.
    /// - Returns: Validation status.
    public func validate(data: String?) -> String.ValidationStatus {
        guard mandatoryStyle.isMandatory == true || data?.isEmpty == false else { return .valid }
        let validationStatus = validationHandler?(data) ?? contentType.getValidationStatus(for: data) ?? .valid
        return validationStatus
    }
    
    /// Determines the validation status of the confirm password field considering its mandatory status.
    /// - Parameters:
    ///   - confirmPasswordData: Confirm password data to be validated.
    ///   - passwordData: Password data.
    /// - Returns: Validation status.
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
    /// Returns the first field with the specified id.
    func first(withId id: Int) -> Element? {
        filter { $0.id == id }.first
    }
}

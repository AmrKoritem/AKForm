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

/// Field properties wrapper.
public class Field {
    var id: Int
    var count: FieldCount
    var type: FieldType
    var contentType: FieldContentType
    var labelStyle: LabelStyle
    var fieldStyle: FieldStyle
    var placeholder: String
    var errorMessages: FieldErrorMessages?

    init(
        id: Int,
        count: FieldCount = .uni,
        type: FieldType,
        contentType: FieldContentType,
        labelStyle: LabelStyle,
        fieldStyle: FieldStyle,
        placeholder: String,
        errorMessages: FieldErrorMessages? = nil
    ) {
        self.id = id
        self.count = count
        self.type = type
        self.contentType = contentType
        self.labelStyle = labelStyle
        self.fieldStyle = fieldStyle
        self.placeholder = placeholder
        self.errorMessages = errorMessages
    }
}

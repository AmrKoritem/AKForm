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
    var errorMessages: FieldErrorMessages?
    var textFieldObserverHandlers: TextFieldObserverHandlers?

    public init(
        id: Int,
        count: FieldCount = .uni,
        type: FieldType,
        contentType: FieldContentType,
        labelStyle: LabelStyle,
        textFieldStyle: TextFieldStyle,
        errorMessages: FieldErrorMessages? = nil,
        textFieldObserverHandlers: TextFieldObserverHandlers? = nil
    ) {
        self.id = id
        self.count = count
        self.type = type
        self.contentType = contentType
        self.labelStyle = labelStyle
        self.textFieldStyle = textFieldStyle
        self.errorMessages = errorMessages
        self.textFieldObserverHandlers = textFieldObserverHandlers
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

public struct TextFieldObserverHandlers {
    var editingHandler: TextFieldEditingChangedHandler
    var editingDidEndHandler: TextFieldEditingDidEnddHandler
    
    public init(
        editingHandler: @escaping TextFieldEditingChangedHandler,
        editingDidEndHandler: @escaping TextFieldEditingDidEnddHandler
    ) {
        self.editingHandler = editingHandler
        self.editingDidEndHandler = editingDidEndHandler
    }
}

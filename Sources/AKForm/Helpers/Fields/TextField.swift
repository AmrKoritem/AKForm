//
//  TextField.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// TextField properties wrapper.
public class TextField: Field {
    var textFieldObserverHandlers: TextFieldObserverHandlers?

    public init(
        id: Int,
        count: FieldCount = .uni,
        contentType: FieldContentType,
        labelStyle: LabelStyle,
        fieldStyle: FieldStyle,
        errorMessages: FieldErrorMessages? = nil,
        textFieldObserverHandlers: TextFieldObserverHandlers? = nil
    ) {
        self.textFieldObserverHandlers = textFieldObserverHandlers
        super.init(
            id: id,
            count: count,
            type: .text,
            contentType: contentType,
            labelStyle: labelStyle,
            fieldStyle: fieldStyle,
            placeholder: placeholder,
            errorMessages: errorMessages
        )
    }
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

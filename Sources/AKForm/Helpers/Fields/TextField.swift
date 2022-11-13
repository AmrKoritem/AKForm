//
//  TextField.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// TextField properties wrapper.
public class TextField: Field {
    var textFieldStyle: TextFieldStyle
    var textFieldObserverHandlers: TextFieldObserverHandlers?

    public init(
        id: Int,
        count: FieldCount = .uni,
        contentType: FieldContentType,
        labelStyle: LabelStyle,
        placeholderStyle: PlaceholderStyle,
        errorMessages: FieldErrorMessages? = nil,
        textFieldStyle: TextFieldStyle,
        textFieldObserverHandlers: TextFieldObserverHandlers? = nil
    ) {
        self.textFieldStyle = textFieldStyle
        self.textFieldObserverHandlers = textFieldObserverHandlers
        super.init(
            id: id,
            count: count,
            type: .text,
            contentType: contentType,
            labelStyle: labelStyle,
            placeholderStyle: placeholderStyle,
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

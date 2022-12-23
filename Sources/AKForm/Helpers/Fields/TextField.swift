//
//  TextField.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// TextField properties wrapper.
public class TextField: Field {
    let textFieldObserverHandlers: TextFieldObserverHandlers?

    public init(
        id: Int,
        count: FieldCount = .uni,
        contentType: Field.ContentType,
        labelStyle: LabelStyle,
        fieldStyle: FieldStyle,
        texts: Texts,
        mandatoryStyle: MandatoryStyle = MandatoryStyle(),
        onFirstResponderStyle: OnFirstResponderStyle? = nil,
        validationHandler: ValidationHandler? = nil,
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
            texts: texts,
            mandatoryStyle: mandatoryStyle,
            onFirstResponderStyle: onFirstResponderStyle,
            validationHandler: validationHandler
        )
    }
}

public typealias TextFieldEditingChangedHandler = (_ text: String?) -> Void
public typealias TextFieldEditingDidEnddHandler = (_ text: String?) -> Void

public struct TextFieldObserverHandlers {
    let editingHandler: TextFieldEditingChangedHandler
    let editingDidEndHandler: TextFieldEditingDidEnddHandler
    
    public init(
        editingHandler: @escaping TextFieldEditingChangedHandler,
        editingDidEndHandler: @escaping TextFieldEditingDidEnddHandler
    ) {
        self.editingHandler = editingHandler
        self.editingDidEndHandler = editingDidEndHandler
    }
}

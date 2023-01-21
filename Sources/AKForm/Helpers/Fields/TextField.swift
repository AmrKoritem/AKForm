//
//  TextField.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// `TextField` properties wrapper.
/// Use this class when you want a text field cell.
public class TextField: Field {
    let textFieldObserverHandlers: TextFieldObserverHandlers?

    /// Initializer for `TextField`.
    /// - Parameters:
    ///   - id: Determines the id of the field.
    ///   - count: Determines if the cell will have single or double fields.
    ///   - contentType: Determines the content data type of the field.
    ///   - labelStyle: Style for the field label.
    ///   - fieldStyle: Style for the data field.
    ///   - texts: The fixed string texts used for the field such as the field label, placeholder, etc.
    ///   - mandatoryStyle: Determines if the field is mandatory as well as the style used to show the mandatory status of the field.
    ///   - firstResponderStyle: Styles to be used when the field content is being changed.
    ///   - validationHandler: Custom validation handler for the field data.
    ///   - textFieldObserverHandlers: Handlers for various editting actions on the text field.
    public init(
        id: Int,
        count: FieldCount = .uni,
        contentType: Field.ContentType,
        labelStyle: LabelStyle,
        fieldStyle: FieldStyle,
        texts: Texts,
        mandatoryStyle: MandatoryStyle = MandatoryStyle(),
        firstResponderStyle: FirstResponderStyle? = nil,
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
            firstResponderStyle: firstResponderStyle,
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

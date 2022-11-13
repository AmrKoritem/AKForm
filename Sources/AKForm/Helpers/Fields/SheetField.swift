//
//  SheetField.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import Foundation

/// SheetField properties wrapper.
public class SheetField: Field {
    var textFieldStyle: TextFieldStyle
    var sheetTextFieldStyle: TextFieldStyle
    var sheetTextFieldObserverHandlers: TextFieldObserverHandlers?
    var optionStyle: OptionStyle
    var options: [String]

    public init(
        id: Int,
        count: FieldCount = .uni,
        contentType: FieldContentType,
        labelStyle: LabelStyle,
        placeholderStyle: PlaceholderStyle,
        errorMessages: FieldErrorMessages? = nil,
        textFieldStyle: TextFieldStyle,
        sheetTextFieldStyle: TextFieldStyle,
        sheetTextFieldObserverHandlers: TextFieldObserverHandlers? = nil,
        optionStyle: OptionStyle = OptionStyle(),
        options: [String]
    ) {
        self.textFieldStyle = textFieldStyle
        self.sheetTextFieldStyle = sheetTextFieldStyle
        self.sheetTextFieldObserverHandlers = sheetTextFieldObserverHandlers
        self.optionStyle = optionStyle
        self.options = options
        super.init(
            id: id,
            count: count,
            type: .sheet,
            contentType: contentType,
            labelStyle: labelStyle,
            placeholderStyle: placeholderStyle,
            errorMessages: errorMessages
        )
    }
}

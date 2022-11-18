//
//  SheetField.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// SheetField properties wrapper.
public class SheetField: Field {
    let sheetBackgroundColor: UIColor
    let sheetBorderStyle: FieldBorderStyle
    let sheetTextFieldStyle: FieldStyle
    let sheetTextFieldObserverHandlers: TextFieldObserverHandlers?
    let optionStyle: OptionStyle
    let options: [String]

    public init(
        id: Int,
        count: FieldCount = .uni,
        contentType: FieldContentType,
        labelStyle: LabelStyle,
        fieldStyle: FieldStyle,
        placeholder: String,
        errorMessages: FieldErrorMessages? = nil,
        mandatory: MandatoryStyle = MandatoryStyle(),
        onFirstResponderStyle: OnFirstResponderStyle? = nil,
        sheetBackgroundColor: UIColor = .white,
        sheetBorderStyle: FieldBorderStyle,
        sheetTextFieldStyle: FieldStyle,
        sheetTextFieldObserverHandlers: TextFieldObserverHandlers? = nil,
        optionStyle: OptionStyle = OptionStyle(),
        options: [String]
    ) {
        self.sheetBackgroundColor = sheetBackgroundColor
        self.sheetBorderStyle = sheetBorderStyle
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
            fieldStyle: fieldStyle,
            placeholder: placeholder,
            errorMessages: errorMessages,
            mandatory: mandatory,
            onFirstResponderStyle: onFirstResponderStyle
        )
    }
}

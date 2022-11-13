//
//  SheetField.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// SheetField properties wrapper.
public class SheetField: Field {
    var sheetBackgroundColor: UIColor
    var sheetBorderStyle: FieldBorderStyle
    var sheetTextFieldStyle: FieldStyle
    var sheetTextFieldObserverHandlers: TextFieldObserverHandlers?
    var optionStyle: OptionStyle
    var options: [String]

    public init(
        id: Int,
        count: FieldCount = .uni,
        contentType: FieldContentType,
        labelStyle: LabelStyle,
        fieldStyle: FieldStyle,
        placeholder: String,
        errorMessages: FieldErrorMessages? = nil,
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
            errorMessages: errorMessages
        )
    }
}

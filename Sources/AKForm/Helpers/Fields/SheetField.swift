//
//  SheetField.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// SheetField properties wrapper.
public class SheetField: Field {
    let sheetStyle: SheetStyle
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
        mandatoryStyle: MandatoryStyle = MandatoryStyle(),
        onFirstResponderStyle: OnFirstResponderStyle? = nil,
        sheetStyle: SheetStyle = SheetStyle(),
        optionStyle: OptionStyle = OptionStyle(),
        options: [String]
    ) {
        self.sheetStyle = sheetStyle
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
            mandatoryStyle: mandatoryStyle,
            onFirstResponderStyle: onFirstResponderStyle
        )
    }
}

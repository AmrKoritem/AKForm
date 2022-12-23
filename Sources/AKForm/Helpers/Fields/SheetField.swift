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
    let options: [SheetOption]

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
        sheetStyle: SheetStyle = SheetStyle(),
        optionStyle: OptionStyle = OptionStyle(),
        options: [SheetOption]
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
            texts: texts,
            mandatoryStyle: mandatoryStyle,
            onFirstResponderStyle: onFirstResponderStyle,
            validationHandler: validationHandler
        )
    }
}

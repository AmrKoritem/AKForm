//
//  SheetField.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// `SheetField` properties wrapper.
/// Use this class when you want a field which presents a new screen with options to choose from.
public class SheetField: Field {
    let sheetStyle: SheetStyle
    let optionStyle: OptionStyle
    let options: [SheetOption]

    /// Initializer for `SheetField`.
    /// - Parameters:
    ///   - id: Determines the id of the field.
    ///   - count: Determines if the cell will have single or double fields.
    ///   - contentType: Determines the content data type of the field.
    ///   - labelStyle: Style for the field label.
    ///   - fieldStyle: Style for the data field.
    ///   - texts: The fixed string texts used for the field such as the field label, placeholder, etc.
    ///   - mandatoryStyle: Determines if the field is mandatory as well as the style used to show the mandatory status of the field.
    ///   - onFirstResponderStyle: Styles to be used when the field content is being changed.
    ///   - validationHandler: Custom validation handler for the field data.
    ///   - sheetStyle: Style for the sheet that will be shown when the field is selected.
    ///   - optionStyle: Style for the option cell in the sheet.
    ///   - options: List of all the options shown in the sheet.
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

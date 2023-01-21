//
//  MakeFields.swift
//  Sportfy-Partner
//
//  Created by Amr Koritem on 12/11/2022.
//

import UIKit
import AKForm

func makeAppTextField(
    id: Int,
    contentType: Field.ContentType,
    labelText: String,
    placeholderText: String,
    errorMessages: Field.ErrorMessages?,
    mandatoryStyle: MandatoryStyle = MandatoryStyle(),
    iconStyleHandler: IconStyleHandler? = nil
) -> TextField {
    TextField(
        id: id,
        contentType: contentType,
        labelStyle: LabelStyle(
            font: .systemFont(ofSize: 16),
            textColor: .black,
            textAlignment: .natural
        ),
        fieldStyle: FieldStyle(
            font: .systemFont(ofSize: 16),
            textColor: .black,
            textAlignment: .natural,
            iconStyleHandler: iconStyleHandler
        ),
        texts: Field.Texts(
            label: labelText,
            placeholder: placeholderText,
            errorMessages: errorMessages
        ),
        mandatoryStyle: mandatoryStyle
    ) {
            let fieldStyle = FieldStyle(
                font: .systemFont(ofSize: 16),
                textColor: .black,
                textAlignment: .natural,
                borderStyle: BorderStyle(color: .blue)
            )
            return (labelStyle: nil, fieldStyle: fieldStyle, mandatoryStyle: nil)
        }
}

func makeAppSheetField(
    id: Int,
    contentType: Field.ContentType,
    texts: (labelText: String, placeholderText: String),
    errorMessages: Field.ErrorMessages?,
    mandatoryStyle: MandatoryStyle = MandatoryStyle(),
    options: [String]
) -> SheetField {
    SheetField(
        id: id,
        contentType: contentType,
        labelStyle: LabelStyle(
            font: .systemFont(ofSize: 16),
            textColor: .black,
            textAlignment: .natural
        ),
        fieldStyle: FieldStyle(
            font: .systemFont(ofSize: 16),
            textColor: .black,
            textAlignment: .natural
        ),
        texts: Field.Texts(
            label: texts.labelText,
            placeholder: texts.placeholderText,
            errorMessages: errorMessages
        ),
        mandatoryStyle: mandatoryStyle,
        firstResponderStyle: {
            let fieldStyle = FieldStyle(
                font: .systemFont(ofSize: 16),
                textColor: .black,
                textAlignment: .natural,
                borderStyle: BorderStyle(color: .blue)
            )
            return (labelStyle: nil, fieldStyle: fieldStyle, mandatoryStyle: nil)
        },
        sheetStyle: SheetStyle(
            borderStyle: BorderStyle(
                color: .clear,
                thickness: 0,
                cornerRadius: 0
            ),
            heightCoefficient: 1,
            closeButtonStyle: .icon(image: UIImage(systemName: "xmark"), tintColor: .blue)
        ),
        optionStyle: OptionStyle(
            separatorStyle: SeparatorStyle(thickness: 0),
            selectionStyle: .backgroundColor(color: .blue.withAlphaComponent(0.25))
        ),
        options: options.compactMap { SheetOption(title: $0) }
    )
}

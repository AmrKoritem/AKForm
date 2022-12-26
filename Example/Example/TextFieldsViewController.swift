//
//  TextFieldsViewController.swift
//  Example
//
//  Created by Amr Koritem on 09/09/2022.
//

import UIKit
import AKForm

class TextFieldsViewController: FormViewController {
    override var fields: [Field] {
        [
            makeAppTextField(
                id: 0,
                contentType: Field.ContentType.name,
                labelText: "Name",
                placeholderText: "Please enter your name",
                errorMessages: Field.ErrorMessages(
                    empty: "Please enter your name",
                    invalid: "Please enter a valid name"
                ),
                mandatoryStyle: MandatoryStyle(isMandatory: true, position: .start)
            ),
            makeAppTextField(
                id: 1,
                contentType: Field.ContentType.email,
                labelText: "Email",
                placeholderText: "Please enter your email",
                errorMessages: Field.ErrorMessages(
                    empty: "Please enter your email",
                    invalid: "Please enter a valid email address"
                ),
                mandatoryStyle: MandatoryStyle(isMandatory: true, position: .end)
            ),
            makeAppTextField(
                id: 2,
                contentType: Field.ContentType.phone,
                labelText: "Phone number",
                placeholderText: "Please enter your phone number",
                errorMessages: Field.ErrorMessages(
                    empty: "Please enter your phone number",
                    invalid: "Please enter a valid phone number"
                ),
                mandatoryStyle: MandatoryStyle(isMandatory: false)
            )
        ]
    }

    override var formHeader: UIView? {
        FormHeader(text: "Text Fields Screen")
    }

    override var formFooter: UIView? {
        FormFooter(title: "Submit") { [weak self] _ in
            guard let self = self else { return }
            guard self.validate() else { return }
            // Do action
        }
    }
}


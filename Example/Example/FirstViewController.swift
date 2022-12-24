//
//  FirstViewController.swift
//  Example
//
//  Created by Amr Koritem on 09/09/2022.
//

import UIKit
import AKForm

class FirstViewController: FormViewController {
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
                mandatoryStyle: MandatoryStyle(isMandatory: true, position: .start)
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
                mandatoryStyle: MandatoryStyle(isMandatory: true, position: .start)
            ),
            makeAppSheetField(
                id: 3,
                contentType: Field.ContentType.name,
                texts: (labelText: "Governorate", placeholderText: "Please enter your governorate"),
                errorMessages: Field.ErrorMessages(
                    empty: "Please enter your governorate",
                    invalid: "Please enter a valid governorate"
                ),
                options: ["Cairo", "Alexandria"]
            ),
            makeAppTextField(
                id: 4,
                contentType: Field.ContentType.address,
                labelText: "Address",
                placeholderText: "Please enter your address",
                errorMessages: Field.ErrorMessages(
                    empty: "Please enter your address",
                    invalid: "Please enter a valid address"
                )
            )
        ]
    }

    override var formHeader: UIView? {
        FormHeader(text: "Join Us")
    }

    override var formFooter: UIView? {
        FormFooter(title: "Subscribe your court") { [weak self] _ in
            guard let self = self else { return }
            guard self.validate() else { return }
            // Do action
        }
    }
}


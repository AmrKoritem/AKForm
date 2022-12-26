//
//  ButtonFieldsViewController.swift
//  Example
//
//  Created by Amr Koritem on 26/09/2022.
//

import UIKit
import AKForm

class ButtonFieldsViewController: FormViewController {
    override var fields: [Field] {
        [
            makeAppSheetField(
                id: 0,
                contentType: Field.ContentType.name,
                texts: (labelText: "Country", placeholderText: "Please enter your country"),
                errorMessages: Field.ErrorMessages(
                    empty: "Please enter your country",
                    invalid: "Please enter a valid country"
                ),
                mandatoryStyle: MandatoryStyle(isMandatory: true, position: .start),
                options: ["Egypt", "Palestine"]
            ),
            makeAppSheetField(
                id: 1,
                contentType: Field.ContentType.name,
                texts: (labelText: "Governorate", placeholderText: "Please enter your governorate"),
                errorMessages: Field.ErrorMessages(
                    empty: "Please enter your governorate",
                    invalid: "Please enter a valid governorate"
                ),
                options: ["Cairo", "Alexandria"]
            )
        ]
    }

    override var formHeader: UIView? {
        FormHeader(text: "Button Fields Screen")
    }

    override var formFooter: UIView? {
        FormFooter(title: "Submit") { [weak self] _ in
            guard let self = self else { return }
            guard self.validate() else { return }
            // Do action
        }
    }
}

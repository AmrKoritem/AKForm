//
//  TextFieldsViewController.swift
//  Example
//
//  Created by Amr Koritem on 09/09/2022.
//

import UIKit
import AKForm

class TextFieldsViewController: UIViewController, FormDataSource {
    var form: AKForm?
    var savedDataMap: [Int: Any] = [:]

    var fields: [Field] {
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

    var formHeader: UIView? {
        FormHeader(text: "Text Fields Screen")
    }

    var formFooter: UIView? {
        FormFooter(title: "Submit") { [weak self] _ in
            guard let self = self else { return }
            guard self.form?.validate() == true else { return }
            // Do action
        }
    }

    var dataMap: [Int: Any] {
        get {
            savedDataMap
        }
        set {
            savedDataMap = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        form = AKForm()
        guard let form = form else { return }
        view.addSubview(form)
        form.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            form.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            form.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            form.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            form.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        form.formHeader = formHeader
        form.formFooter = formFooter
        form.dataSource = self
    }

    func header(for section: Int) -> UIView? {
        nil
    }

    func footer(for section: Int) -> UIView? {
        nil
    }
}


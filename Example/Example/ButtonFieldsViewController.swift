//
//  ButtonFieldsViewController.swift
//  Example
//
//  Created by Amr Koritem on 26/09/2022.
//

import UIKit
import AKForm
import AKHelpers

class ButtonFieldsViewController: AKFormViewController {
    override var fields: [Field] {
        [
            SheetField(
                id: 0,
                contentType: .name,
                texts: Field.Texts(
                    label: "Country",
                    placeholder: "Please enter your country",
                    errorMessages: Field.ErrorMessages(
                        empty: "Please enter your country",
                        invalid: "Please enter a valid country"
                    )
                ),
                mandatoryStyle: MandatoryStyle(isMandatory: true, position: .start),
                sheetStyle: SheetStyle(
                    borderStyle: BorderStyle(color: .clear, cornerRadius: 0),
                    heightCoefficient: 1,
                    closeButtonStyle: .icon(image: UIImage(systemName: "xmark"), tintColor: .blue)
                ),
                optionStyle: OptionStyle(separatorStyle: SeparatorStyle(thickness: 0)),
                options: ["Egypt", "Palestine"].compactMap { SheetOption(title: $0) }
            ),
            SheetField(
                id: 1,
                contentType: .name,
                texts: Field.Texts(
                    label: "Governorate",
                    placeholder: "Please enter your governorate",
                    errorMessages: Field.ErrorMessages(
                        empty: "Please enter your governorate",
                        invalid: "Please enter a valid governorate"
                    )
                ),
                sheetStyle: SheetStyle(
                    borderStyle: BorderStyle(color: .clear, cornerRadius: 0),
                    heightCoefficient: 1,
                    closeButtonStyle: .icon(image: UIImage(systemName: "xmark"), tintColor: .blue)
                ),
                optionStyle: OptionStyle(separatorStyle: SeparatorStyle(thickness: 0)),
                options: ["Cairo", "Alexandria"].compactMap { SheetOption(title: $0) }
            ),
            ButtonField(
                id: 2,
                contentType: .name,
                texts: Field.Texts(label: "Just Button", placeholder: "Button placeholder"),
                actionHandler: { [weak self] in
                    let dataSource = QuickFormDataSource(
                        fields: [TextField(
                            id: 1,
                            contentType: .email,
                            texts: Field.Texts(
                                label: "Email",
                                placeholder: "Please enter your email"
                            )
                        )],
                        footer: FormFooter(title: "Dismiss") { [weak self] _ in
                            self?.dismiss(animated: true)
                        }
                    )
                    let vc = AKFormViewController(quickDataSource: dataSource)
                    vc.view.backgroundColor = .white
                    self?.presentAsSheet(
                        viewController: vc,
                        height: 450
                    )
                }
            ),
            ButtonField(
                id: 3,
                contentType: .name,
                texts: Field.Texts(label: "Another Button", placeholder: "Button placeholder"),
                actionHandler: { [weak self] in
                    let vc = AKFormViewController(
                        fields: [TextField(
                            id: 1,
                            contentType: .email,
                            texts: Field.Texts(
                                label: "Name",
                                placeholder: "Please enter your name"
                            )
                        )],
                        footer: FormFooter(title: "Dismiss") { [weak self] _ in
                            self?.dismiss(animated: true)
                        })
                    vc.view.backgroundColor = .white
                    self?.presentAsSheet(
                        viewController: vc,
                        height: 450
                    )
                }
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

    override func viewDidLoad() {
        super.viewDidLoad()
        let snapshotView = UIView(frame: .zero)
        snapshotView.backgroundColor = .yellow
        akform.snapshotView = snapshotView
    }
}

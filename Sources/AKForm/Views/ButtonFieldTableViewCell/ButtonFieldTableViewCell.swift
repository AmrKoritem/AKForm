//
//  ButtonFieldTableViewCell.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

class ButtonFieldTableViewCell: UITableViewCell, FieldTableViewCellProtocol {
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var fieldHeightConstraint: NSLayoutConstraint!

    var labelStyle: LabelStyle?
    var fieldStyle: FieldStyle?
    var placeholder: String?
    var buttonText: String?

    private var buttonActionHandler: () -> Void = {}

    @IBAction func buttonAction() {
        buttonActionHandler()
    }

    func configure(
        field: Field,
        fieldText: String?,
        buttonActionHandler: @escaping () -> Void
    ) {
        labelStyle = field.labelStyle
        fieldStyle = field.fieldStyle
        placeholder = field.placeholder
        buttonText = fieldText
        fieldLabel.setStyle(with: field.labelStyle)
        clearFieldUI()
        self.buttonActionHandler = buttonActionHandler
    }

    func setFieldBorder() {
        guard let borderStyle = fieldStyle?.borderStyle else { return }
        button.setBorder(with: borderStyle)
    }

    func setPlaceholder() {
        if let fieldText = buttonText {
            button.setTitle(fieldText, for: .normal)
        } else {
            let attributes = fieldStyle?.placeholderAttributes ?? [
                NSAttributedString.Key.foregroundColor: Default.Colors.placeholder,
                NSAttributedString.Key.font: Default.Fonts.placeholder
            ]
            button.setAttributedTitle(
                NSAttributedString(
                    string: placeholder ?? "",
                    attributes: attributes),
                for: .normal
            )
        }
    }

    func showError(message: String, shouldClearText: Bool) {
        button.stroked(
            with: fieldStyle?.borderStyle.borderWidth ?? Default.Dimensions.borderWidth,
            color: Default.Colors.errorBorder
        )
        errorLabel.text = message
        errorLabel.isHidden = false
        guard shouldClearText else { return }
        button.setTitle("", for: .normal)
    }

    func clearFieldUI() {
        errorLabel.isHidden = true
        setFieldBorder()
        setPlaceholder()
        guard let fieldStyle = fieldStyle else { return }
        button.setStyle(with: fieldStyle)
    }
}

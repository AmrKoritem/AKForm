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
        fieldLabel.setStyle(with: field.labelStyle)
        if let fieldText = fieldText {
            button.setTitle(fieldText, for: .normal)
        } else {
            button.setAttributedTitle(
                NSAttributedString(
                    string: field.placeholder,
                    attributes: field.fieldStyle.placeholderAttributes),
                for: .normal
            )
        }
        clearFieldUI()
        self.buttonActionHandler = buttonActionHandler
    }

    func setFieldBorder() {
        guard let borderStyle = fieldStyle?.borderStyle else {
            button.stroked(
                with: fieldStyle?.borderStyle?.borderWidth ?? 1,
                color: fieldStyle?.borderStyle?.borderColor ?? .lightGray
            )
            return
        }
        button.setBorder(with: borderStyle)
    }

    func showError(message: String, shouldClearText: Bool) {
        button.stroked(with: fieldStyle?.borderStyle?.borderWidth ?? 1, color: .systemRed)
        errorLabel.text = message
        errorLabel.isHidden = false
        guard shouldClearText else { return }
        button.setTitle("", for: .normal)
    }

    func clearFieldUI() {
        errorLabel.isHidden = true
        setFieldBorder()
        guard let fieldStyle = fieldStyle else { return }
        button.setStyle(with: fieldStyle)
    }
}

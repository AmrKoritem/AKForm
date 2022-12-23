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

    var field: Field?
    var buttonText: String?

    private var buttonActionHandler: () -> Void = {}

    @IBAction func buttonAction() {
        buttonActionHandler()
        guard let field = field?.getOnFirstResponderCopy() else { return }
        setStyles(with: field)
    }

    func configure(
        field: Field,
        fieldText: String?,
        buttonActionHandler: @escaping () -> Void
    ) {
        self.field = field
        buttonText = fieldText
        button.titleEdgeInsets.left = Default.Dimensions.horizontalPadding
        button.titleEdgeInsets.right = Default.Dimensions.horizontalPadding
        clearFieldUI()
        self.buttonActionHandler = buttonActionHandler
    }

    func setPlaceholder(with placeholder: String? = nil, or placeholderAttributes: [NSAttributedString.Key: Any]? = nil) {
        if let fieldText = buttonText, !fieldText.isEmpty {
            let color = field?.fieldStyle.textColor
            let font = field?.fieldStyle.font
            let attributes = StringAttributes.from(color: color, font: font)
            button.setAttributedTitle(
                NSAttributedString(
                    string: fieldText,
                    attributes: attributes),
                for: .normal
            )
        } else {
            let attributes = placeholderAttributes ?? field?.fieldStyle.placeholderAttributes ?? StringAttributes.defaultPlaceholder
            button.setAttributedTitle(
                NSAttributedString(
                    string: placeholder ?? field?.texts.placeholder ?? "",
                    attributes: attributes),
                for: .normal
            )
        }
    }

    func setIcons(with iconStyleHandler: IconStyleHandler? = nil) {
        // TODO: - implementation
    }

    func setStyles(with field: Field) {
        fieldLabel.attributedText = NSAttributedString(string: field.texts.label, attributes: field.labelStyle.attributes)
        fieldLabel.setStyle(with: field.mandatoryStyle)
        setPlaceholder(with: field.texts.placeholder, or: field.fieldStyle.placeholderAttributes)
        button.setStyle(with: field.fieldStyle)
    }

    func showError(message: String, shouldClearText: Bool) {
        button.stroked(
            with: field?.fieldStyle.borderStyle.thickness ?? Default.Dimensions.borderWidth,
            color: Default.Colors.errorBorder
        )
        errorLabel.text = message
        errorLabel.isHidden = false
        guard shouldClearText else { return }
        button.setTitle("", for: .normal)
        button.setAttributedTitle(nil, for: .normal)
    }

    func clearFieldUI() {
        errorLabel.isHidden = true
        guard let field = field else { return }
        setStyles(with: field)
    }
}

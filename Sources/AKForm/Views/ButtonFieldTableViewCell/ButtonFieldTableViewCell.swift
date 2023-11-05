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
    @IBOutlet weak var labelToFieldVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var fieldHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var fieldToErrorLabelVerticalConstraint: NSLayoutConstraint!

    var field: Field?
    var buttonText: String?

    private var buttonActionHandler: () -> Void = {}

    @IBAction func buttonAction() {
        buttonActionHandler()
        guard let field = field?.firstResponderCopy else { return }
        setStyles(with: field)
    }

    func configure(
        field: Field,
        fieldText: String?,
        buttonActionHandler: @escaping () -> Void
    ) {
        self.field = field
        buttonText = fieldText
        setDimenions()
        clearFieldUI()
        self.buttonActionHandler = buttonActionHandler
    }
    
    func setDimenions() {
        guard let field = field else { return }
        button.titleEdgeInsets.left = field.fieldStyle.dimensions.placeholderLeading
        button.titleEdgeInsets.right = field.fieldStyle.dimensions.placeholderLeading
        labelToFieldVerticalConstraint.constant = field.fieldStyle.dimensions.labelToField
    }

    func setPlaceholder(
        with placeholder: String? = nil,
        and placeholderAttributes: [NSAttributedString.Key: Any]? = nil
    ) {
        guard let fieldText = buttonText, !fieldText.isEmpty else {
            let placeholder = placeholder ?? field?.texts.placeholder ?? ""
            let attributes = placeholderAttributes ?? field?.fieldStyle.placeholderAttributes
            let attrText = NSAttributedString(
                string: placeholder,
                attributes: attributes ?? StringAttributes.defaultPlaceholder
            )
            button.setAttributedTitle(attrText, for: .normal)
            return
        }
        let attributes = field?.fieldStyle.textAttributes
        let attrText = NSAttributedString(string: fieldText, attributes: attributes)
        button.setAttributedTitle(attrText, for: .normal)
    }

    func setIcons(with iconStyleHandler: IconStyleHandler? = nil) {
        // TODO: - implementation
    }

    func setStyles(with field: Field) {
        fieldLabel.attributedText = NSAttributedString(string: field.texts.label, attributes: field.labelStyle.attributes)
        fieldLabel.setStyle(with: field.mandatoryStyle)
        button.setStyle(with: buttonText, andStyle: field.fieldStyle)
        setPlaceholder(with: field.texts.placeholder, and: field.fieldStyle.placeholderAttributes)
    }

    func showError(message: String, shouldClearText: Bool) {
        button.stroked(
            with: field?.fieldStyle.borderStyle.thickness ?? Default.Dimensions.borderWidth,
            color: Default.Colors.errorBorder
        )
        errorLabel.text = message
        errorLabel.isHidden = false
        guard shouldClearText else { return }
        button.setTitle(nil, for: .normal)
        button.setAttributedTitle(nil, for: .normal)
    }

    func clearFieldUI() {
        errorLabel.isHidden = true
        guard let field = field else { return }
        setStyles(with: field)
    }
}

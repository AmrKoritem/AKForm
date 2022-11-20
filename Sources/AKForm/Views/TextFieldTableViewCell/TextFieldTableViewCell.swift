//
//  TextFieldTableViewCell.swift
//  AKForm
//
//  Created by Amr Koritem on 10/11/2022.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell, FieldTableViewCellProtocol {
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var textFieldHeightConstraint: NSLayoutConstraint!

    var field: Field?

    private var textFieldEditingHandler: TextFieldEditingChangedHandler = { _ in }
    private var textFieldEditingDidEndHandler: TextFieldEditingDidEnddHandler = { _ in }

    deinit {
        textField.removeTarget(self, action: #selector(textFieldChangeDidBegin(_:)), for: .editingDidBegin)
        textField.removeTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        textField.removeTarget(self, action: #selector(textFieldChangeDidEnd(_:)), for: .editingDidEnd)
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        guard textField != nil else { return }
        textField.addTarget(self, action: #selector(textFieldChangeDidBegin(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldChangeDidEnd(_:)), for: .editingDidEnd)
    }

    func configure(
        field: Field,
        textFieldText: String?,
        textFieldEditingHandler: @escaping TextFieldEditingChangedHandler,
        textFieldEditingDidEndHandler: @escaping TextFieldEditingDidEnddHandler
    ) {
        self.field = field
        textField.text = textFieldText
        textField.setHorizontalPadding(to: Default.Dimensions.horizontalPadding)
        clearFieldUI()
        textField.setTypingAttributes(with: field.contentType)
        self.textFieldEditingHandler = textFieldEditingHandler
        self.textFieldEditingDidEndHandler = textFieldEditingDidEndHandler
    }

    func setFieldBorder(with borderStyle: FieldBorderStyle? = nil) {
        guard let borderStyle = borderStyle ?? field?.fieldStyle.borderStyle else { return }
        textFieldView.setBorder(with: borderStyle)
    }

    func setPlaceholder(with placeholder: String? = nil, or placeholderAttributes: [NSAttributedString.Key: Any]? = nil) {
        let placeholder = placeholder ?? field?.placeholder ?? ""
        guard let placeholderAttributes = placeholderAttributes ?? field?.fieldStyle.placeholderAttributes else {
            textField.placeholder = placeholder
            return
        }
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: placeholderAttributes
        )
    }

    func setIcons(with iconStyleHandler: IconStyleHandler? = nil) {
        guard let iconStyleHandler = iconStyleHandler ?? field?.fieldStyle.iconStyleHandler else { return }
        textField.setIcons(with: iconStyleHandler)
    }

    func setStyles(with field: Field) {
        fieldLabel.setStyle(with: field.labelStyle, mandatoryStyle: field.mandatoryStyle)
        setFieldBorder(with: field.fieldStyle.borderStyle)
        setPlaceholder(with: field.placeholder, or: field.fieldStyle.placeholderAttributes)
        textField.setStyle(with: field.fieldStyle)
        setIcons(with: field.fieldStyle.iconStyleHandler)
    }

    func showError(message: String, shouldClearText: Bool) {
        textFieldView.stroked(
            with: field?.fieldStyle.borderStyle.borderWidth ?? Default.Dimensions.borderWidth,
            color: Default.Colors.errorBorder
        )
        errorLabel.text = message
        errorLabel.isHidden = false
        guard shouldClearText else { return }
        textField.text = ""
    }

    func clearFieldUI() {
        textField.attributedPlaceholder = nil
        errorLabel.isHidden = true
        guard let field = field else { return }
        setStyles(with: field)
    }

    @objc
    func textFieldChangeDidBegin(_ textField: UITextField) {
        guard let field = field?.getOnFirstResponderCopy() else { return }
        setStyles(with: field)
    }

    @objc
    func textFieldChange(_ textField: UITextField) {
        textFieldEditingHandler(textField.text)
    }

    @objc
    func textFieldChangeDidEnd(_ textField: UITextField) {
        textFieldEditingDidEndHandler(textField.text)
        guard let field = field else { return }
        setStyles(with: field)
    }
}

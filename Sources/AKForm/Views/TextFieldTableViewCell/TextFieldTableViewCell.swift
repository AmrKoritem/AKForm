//
//  TextFieldTableViewCell.swift
//  AKForm
//
//  Created by Amr Koritem on 10/11/2022.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell, FieldTableViewCellProtocol {
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var textFieldStack: UIStackView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var textFieldHeightConstraint: NSLayoutConstraint!

    var field: Field?
    var leadingIconView: UIView?
    var trailingIconView: UIView?

    private var textFieldEditingHandler: TextFieldEditingHandler = { _ in }
    private var textFieldEditingDidEndHandler: TextFieldEditingHandler = { _ in }

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
        textFieldEditingHandler: @escaping TextFieldEditingHandler,
        textFieldEditingDidEndHandler: @escaping TextFieldEditingHandler
    ) {
        self.field = field
        textField.text = textFieldText
        textField.setHorizontalPadding(to: Default.Dimensions.horizontalPadding)
        clearFieldUI()
        textField.setTypingAttributes(with: field.contentType)
        self.textFieldEditingHandler = textFieldEditingHandler
        self.textFieldEditingDidEndHandler = textFieldEditingDidEndHandler
    }

    func setPlaceholder(
        with placeholder: String? = nil,
        and placeholderAttributes: [NSAttributedString.Key: Any]? = nil
    ) {
        let placeholder = placeholder ?? field?.texts.placeholder ?? ""
        let placeholderAttributes = placeholderAttributes ?? field?.fieldStyle.placeholderAttributes ?? StringAttributes.defaultPlaceholder
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: placeholderAttributes
        )
    }

    func setIcons(with iconStyleHandler: IconStyleHandler? = nil) {
        guard let iconStyleHandler = iconStyleHandler ?? field?.fieldStyle.iconStyleHandler else { return }
        if let leadingIconView = leadingIconView {
            textFieldStack.removeArrangedSubview(leadingIconView)
            leadingIconView.removeFromSuperview()
        }
        if let trailingIconView = trailingIconView {
            textFieldStack.removeArrangedSubview(trailingIconView)
            trailingIconView.removeFromSuperview()
        }
        let iconViewSize = CGSize(width: 21, height: textFieldHeightConstraint.constant)
        let semanticContentAttribute = UIView.appearance().semanticContentAttribute
        let isLeft = semanticContentAttribute == .forceLeftToRight
        if let leadingIconStyle = iconStyleHandler().leading {
            let leadingIconView = leadingIconStyle.getIconContainerView(iconViewSize: iconViewSize, isLeft: isLeft)
            self.leadingIconView = leadingIconView
            textFieldStack.insertArrangedSubview(leadingIconView, at: 0)
        }
        if let trailingIconStyle = iconStyleHandler().trailing {
            let trailingIconView = trailingIconStyle.getIconContainerView(iconViewSize: iconViewSize, isLeft: !isLeft)
            self.trailingIconView = trailingIconView
            textFieldStack.addArrangedSubview(trailingIconView)
        }
    }

    func setStyles(with field: Field) {
        fieldLabel.attributedText = NSAttributedString(
            string: field.texts.label,
            attributes: field.labelStyle.attributes
        )
        fieldLabel.setStyle(with: field.mandatoryStyle)
        setPlaceholder(with: field.texts.placeholder, and: field.fieldStyle.placeholderAttributes)
        textField.setStyle(with: textField.text, andStyle: field.fieldStyle)
        textField.stroked(color: .clear)
        textField.shadowRemoved()
        setIcons(with: field.fieldStyle.iconStyleHandler)
        textFieldView.backgroundColor = field.fieldStyle.backgroundColor
        textFieldView.stroked(with: field.fieldStyle.borderStyle)
        guard let shadowStyle = field.fieldStyle.shadowStyle else { return }
        textFieldView.shadowed(with: shadowStyle)
    }

    func showError(message: String, shouldClearText: Bool) {
        textFieldView.stroked(
            with: field?.fieldStyle.borderStyle.thickness ?? Default.Dimensions.borderWidth,
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
        guard let field = field?.firstResponderCopy else { return }
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

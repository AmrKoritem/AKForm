//
//  TextFieldTableViewCell.swift
//  AKForm
//
//  Created by Amr Koritem on 10/11/2022.
//

import UIKit

public typealias TextFieldEditingChangedHandler = (String?) -> Void
public typealias TextFieldEditingDidEnddHandler = (String?) -> Void

public class TextFieldTableViewCell: UITableViewCell, FieldTableViewCellProtocol {
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var textFieldHeightConstraint: NSLayoutConstraint!

    var labelStyle: LabelStyle?
    var fieldStyle: FieldStyle?
    var placeholder: String?

    private var textFieldEditingHandler: TextFieldEditingChangedHandler = { _ in }
    private var textFieldEditingDidEndHandler: TextFieldEditingDidEnddHandler = { _ in }

    deinit {
        textField.removeTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        textField.removeTarget(self, action: #selector(textFieldChangeDidEnd(_:)), for: .editingDidEnd)
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        guard textField != nil else { return }
        textField.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldChangeDidEnd(_:)), for: .editingDidEnd)
    }

    func configure(
        field: Field,
        textFieldText: String?,
        textFieldEditingHandler: @escaping TextFieldEditingChangedHandler,
        textFieldEditingDidEndHandler: @escaping TextFieldEditingDidEnddHandler
    ) {
        labelStyle = field.labelStyle
        fieldStyle = field.fieldStyle
        placeholder = field.placeholder
        fieldLabel.setStyle(with: field.labelStyle)
        textField.text = textFieldText
        clearFieldUI()
        textField.setTypingAttributes(with: field.contentType)
        self.textFieldEditingHandler = textFieldEditingHandler
        self.textFieldEditingDidEndHandler = textFieldEditingDidEndHandler
    }

    func setFieldBorder() {
        guard let borderStyle = fieldStyle?.borderStyle else { return }
        textFieldView.setBorder(with: borderStyle)
    }

    func setPlaceholder() {
        guard let placeholderAttributes = fieldStyle?.placeholderAttributes else {
            textField.placeholder = placeholder
            return
        }
        textField.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: placeholderAttributes)
    }

    func showError(message: String, shouldClearText: Bool) {
        textFieldView.stroked(
            with: fieldStyle?.borderStyle.borderWidth ?? Default.Dimensions.borderWidth,
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
        setFieldBorder()
        setPlaceholder()
        guard let textFieldStyle = fieldStyle else { return }
        textField.setStyle(with: textFieldStyle)
    }

    @objc
    func textFieldChange(_ textField: UITextField) {
        textFieldEditingHandler(textField.text)
    }

    @objc
    func textFieldChangeDidEnd(_ textField: UITextField) {
        textFieldEditingDidEndHandler(textField.text)
    }
}

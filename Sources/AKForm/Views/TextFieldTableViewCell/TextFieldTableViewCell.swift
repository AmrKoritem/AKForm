//
//  TextFieldTableViewCell.swift
//  AKForm
//
//  Created by Amr Koritem on 10/11/2022.
//

import UIKit

public typealias TextFieldEditingChangedHandler = (String?) -> Void
public typealias TextFieldEditingDidEnddHandler = (String?) -> Void

public class TextFieldTableViewCell: UITableViewCell {
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var textFieldHeightConstraint: NSLayoutConstraint!

    var labelStyle: LabelStyle?
    var textFieldStyle: TextFieldStyle?
    var placeholderStyle: PlaceholderStyle?
    var textFieldEditingHandler: TextFieldEditingChangedHandler = { _ in }
    var textFieldEditingDidEndHandler: TextFieldEditingDidEnddHandler = { _ in }

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
        field: TextField,
        textFieldText: String?,
        textFieldEditingHandler: @escaping TextFieldEditingChangedHandler,
        textFieldEditingDidEndHandler: @escaping TextFieldEditingDidEnddHandler
    ) {
        labelStyle = field.labelStyle
        fieldLabel.setStyle(with: field.labelStyle)
        textField.text = textFieldText
        textFieldStyle = field.textFieldStyle
        placeholderStyle = field.placeholderStyle
        clearFieldUI()
        textField.setTypingAttributes(with: field.contentType)
        self.textFieldEditingHandler = textFieldEditingHandler
        self.textFieldEditingDidEndHandler = textFieldEditingDidEndHandler
    }

    func setFieldBorder() {
        textFieldView.stroked(
            with: textFieldStyle?.borderStyle?.borderWidth ?? 1,
            color: textFieldStyle?.borderStyle?.borderColor ?? .lightGray
        )
        guard let borderStyle = textFieldStyle?.borderStyle else { return }
        textFieldView.layer.cornerRadius = borderStyle.cornerRadius
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

extension TextFieldTableViewCell: FieldTableViewCellProtocol {
    func showError(message: String, shouldClearText: Bool) {
        textFieldView.stroked(with: textFieldStyle?.borderStyle?.borderWidth ?? 1, color: .systemRed)
        errorLabel.text = message
        errorLabel.isHidden = false
        guard shouldClearText else { return }
        textField.text = ""
    }

    func clearFieldUI() {
        textField.attributedPlaceholder = nil
        errorLabel.isHidden = true
        setFieldBorder()
        guard let textFieldStyle = textFieldStyle, let placeholderStyle = placeholderStyle else { return }
        textField.setStyle(with: textFieldStyle, and: placeholderStyle)
    }
}

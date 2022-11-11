//
//  TextFieldTableViewCell.swift
//  AKForm
//
//  Created by Amr Koritem on 10/11/2022.
//

import UIKit

public typealias TextFieldEditingChangedHandler = (String?) -> Void
public typealias TextFieldEditingDidEnddHandler = (String?) -> Void

class TextFieldTableViewCell: UITableViewCell {
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldView: UIView!

    var textFieldEditingHandler: TextFieldEditingChangedHandler = { _ in }
    var textFieldEditingDidEndHandler: TextFieldEditingDidEnddHandler = { _ in }

    deinit {
        textField.removeTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        textField.removeTarget(self, action: #selector(textFieldChangeDidEnd(_:)), for: .editingDidEnd)
    }

    override func awakeFromNib() {
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
        fieldLabel.text = field.labelStyle.text
        fieldLabel.attributedText = field.labelStyle.attributedText
        textField.text = textFieldText
        textField.setStyle(with: field.textFieldStyle)
        textField.setTypingAttributes(with: field.contentType)
        textField.placeholder = field.textFieldStyle.placeholderStyle.text
        textField.attributedPlaceholder = field.textFieldStyle.placeholderStyle.attributedText
        self.textFieldEditingHandler = textFieldEditingHandler
        self.textFieldEditingDidEndHandler = textFieldEditingDidEndHandler
    }

    func showError(message: String, clearText: Bool = false) {
        textFieldView.stroked(with: 1, color: .red)
        textField.attributedPlaceholder = NSAttributedString.errorPlaceholder(message)
        guard clearText else { return }
        textField.text = ""
    }

    func clearField(_ placeholderStyle: PlaceholderStyle) {
        textFieldView.stroked(with: 0, color: .clear)
        textField.attributedPlaceholder = placeholderStyle.attributedText
    }

    @objc
    func textFieldChange(_ textField: UITextField) {
        textField.textColor = .white
        textFieldEditingHandler(textField.text)
    }

    @objc
    func textFieldChangeDidEnd(_ textField: UITextField) {
        textFieldEditingDidEndHandler(textField.text)
    }
}

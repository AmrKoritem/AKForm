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
    @IBOutlet weak var textFieldHeightConstraint: NSLayoutConstraint!
    
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
        field: Field,
        textFieldText: String?,
        textFieldEditingHandler: @escaping TextFieldEditingChangedHandler,
        textFieldEditingDidEndHandler: @escaping TextFieldEditingDidEnddHandler
    ) {
        fieldLabel.setStyle(with: field.labelStyle)
        textField.text = textFieldText
        textField.setStyle(with: field.textFieldStyle)
        textField.setTypingAttributes(with: field.contentType)
        textFieldView.stroked(with: 1, color: .lightGray)
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
        textFieldView.stroked(with: 1, color: .lightGray)
        textField.attributedPlaceholder = placeholderStyle.attributedText
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

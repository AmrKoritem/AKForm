//
//  FieldTableViewCellProtocol.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

protocol FieldTableViewCellProtocol: UITableViewCell {
    var field: Field? { get }
    func setPlaceholder(with placeholder: String?, or placeholderAttributes: [NSAttributedString.Key: Any]?)
    func setIcons(with iconStyleHandler: IconStyleHandler?)
    func setStyles(with field: Field)
    func showError(message: String, shouldClearText: Bool)
    func clearFieldUI()
}

extension FieldTableViewCellProtocol {
    func showError(for status: String.ValidationStatus) {
        let errorMessage = field?.texts.errorMessages.message(for: status) ?? ""
        errorMessage.isEmpty ? clearFieldUI() : showError(message: errorMessage)
    }

    func showError(message: String) {
        showError(message: message, shouldClearText: false)
    }

    func validate(data: String?) {
        showError(for: field?.validate(data: data) ?? .valid)
    }

    func validateConfirmPassword(_ confirmPasswordData: String?, passwordData: String?) {
        let validationStatus = field?.validateConfirmPassword(confirmPasswordData, passwordData: passwordData)
        showError(for: validationStatus ?? .valid)
    }
}

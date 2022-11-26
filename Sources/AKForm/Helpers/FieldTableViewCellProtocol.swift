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
    func showError(message: String) {
        showError(message: message, shouldClearText: false)
    }

    func validate(data: String?) {
        guard field?.mandatoryStyle.isMandatory == true || data?.isEmpty == false else { return }
        switch field?.contentType.getValidationStatus(for: data) ?? .valid {
        case .invalid:
            showError(message: field?.errorMessages?.invalid ?? "Please enter a valid entry")
        case .missing:
            showError(message: field?.errorMessages?.empty ?? "Please enter your data")
        default:
            clearFieldUI()
        }
    }

    func validateConfirmPassword(_ confirmPasswordData: String?, passwordData: String?) {
        guard field?.mandatoryStyle.isMandatory == true || confirmPasswordData?.isEmpty == false else { return }
        if passwordData?.isEmpty != false {
            showError(message: field?.errorMessages?.empty ?? "Please enter your password")
        } else if passwordData != confirmPasswordData {
            showError(message: field?.errorMessages?.invalid ?? "Must be the same as the password")
        } else {
            clearFieldUI()
        }
    }
}

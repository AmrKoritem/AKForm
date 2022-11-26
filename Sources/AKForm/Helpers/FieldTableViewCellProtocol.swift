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
        let validationStatus = field?.validationHandler?(data) ?? field?.contentType.getValidationStatus(for: data) ?? .valid
        switch validationStatus {
        case .valid:
            clearFieldUI()
        default:
            showError(message: field?.errorMessages.message(for: validationStatus) ?? "")
        }
    }

    func validateConfirmPassword(_ confirmPasswordData: String?, passwordData: String?) {
        guard field?.mandatoryStyle.isMandatory == true || confirmPasswordData?.isEmpty == false else { return }
        let validationStatus = field?.validationHandler?(confirmPasswordData) ?? { () -> String.ValidationStatus in
            if passwordData?.isEmpty != false {
                return String.ValidationStatus.missing
            } else if passwordData != confirmPasswordData {
                return String.ValidationStatus.invalid
            } else {
                return String.ValidationStatus.valid
            }
        }()
        let errorMessage = field?.errorMessages.message(for: validationStatus) ?? ""
        errorMessage.isEmpty ? clearFieldUI() : showError(message: errorMessage)
    }
}

//
//  FieldTableViewCellProtocol.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

protocol FieldTableViewCellProtocol: UITableViewCell {
    var labelStyle: LabelStyle? { get }
    var fieldStyle: FieldStyle? { get }
    func showError(message: String, shouldClearText: Bool)
    func clearFieldUI()
}

extension FieldTableViewCellProtocol {
    func showError(message: String) {
        showError(message: message, shouldClearText: false)
    }
}

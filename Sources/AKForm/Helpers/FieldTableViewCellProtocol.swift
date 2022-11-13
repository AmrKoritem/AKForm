//
//  FieldTableViewCellProtocol.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

protocol FieldTableViewCellProtocol: UITableViewCell {
    func showError(message: String, shouldClearText: Bool)
    func clearField(_ placeholderStyle: PlaceholderStyle)
}

extension FieldTableViewCellProtocol {
    func showError(message: String) {
        showError(message: message, shouldClearText: false)
    }
}

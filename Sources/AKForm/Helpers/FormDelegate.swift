//
//  FormDelegate.swift
//  AKForm
//
//  Created by Amr Koritem on 10/11/2022.
//

import UIKit

/// Data source of form screen.
public protocol FormDataSource: AnyObject {
    /// Form fields.
    var fields: [Field] { get }
    /// Form data filled by the user.
    var dataMap: [Int: Any] { get set }
    /// Form header view.
    /// - Parameter section: Form section.
    /// - Returns: Header view.
    func header(for section: Int) -> UIView?
    /// Form footer view.
    /// - Parameter section: Form section.
    /// - Returns: footer view.
    func footer(for section: Int) -> UIView?
}

/// Delegate of form screen.
public class FormDelegate: NSObject {
    private(set) var dataSource: FormDataSource?
    
    /// Initializer for `FormDelegate`.
    /// - Parameter dataSource: Data source for the delegate.
    public init(dataSource: FormDataSource?) {
        self.dataSource = dataSource
    }
}

public extension UITableView {
    /// Registers all the table view cells corresponding to fields provided to the table view.
    /// - Parameter fields: Form fields.
    func register(fields: [Field]) {
        fields.forEach { field in
            switch field.type {
            case .text:
                registerNib(TextFieldTableViewCell.self)
            case .sheet, .button:
                registerNib(ButtonFieldTableViewCell.self)
            case .custom:
                let cField = field as? CustomField
                cField?.delegate?.register(to: self)
            }
        }
    }
}

public extension FormDelegate {
    /// Dictionary containing the current validation status for each field id.
    var validationStatus: [Int: String.ValidationStatus] {
        dataSource?.fields.reduce([Int: String.ValidationStatus]()) { [weak self] dict, field in
            let data = self?.dataSource?.dataMap[field.id] as? String
            let validationStatus: String.ValidationStatus = {
                switch field.contentType {
                case .confirmPassword(let passwordFieldId, _):
                    let passwordData = self?.dataSource?.dataMap[passwordFieldId] as? String
                    return field.validateConfirmPassword(data, passwordData: passwordData)
                default:
                    return field.validate(data: data)
                }
            }()
            var dict = dict
            dict[field.id] = validationStatus
            return dict
        } ?? [:]
    }
    
    /// Determines if the fields data are valid.
    var isDataValid: Bool {
        !validationStatus.values.contains(.missing) && !validationStatus.values.contains(.invalid)
    }
    
    /// Fills all nil entries of the fields data with empty space so that it gets validated during the validation process.
    /// - Returns: Boolean that determines if the fields data are valid.
    func validate() -> Bool {
        for field in dataSource?.fields ?? [] {
            guard dataSource?.dataMap[field.id] == nil else { continue }
            dataSource?.dataMap[field.id] = ""
        }
        return isDataValid
    }
}

extension FormDelegate {
    func validate(
        cell: FieldTableViewCellProtocol?,
        for contentType: Field.ContentType,
        data: String?
    ) {
        switch contentType {
        case .confirmPassword(let passwordFieldId, _):
            let passwordData = dataSource?.dataMap[passwordFieldId] as? String
            cell?.validateConfirmPassword(data, passwordData: passwordData)
        default:
            cell?.validate(data: data)
        }
    }
}

extension FormDelegate: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource?.fields.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let field = dataSource?.fields[safe: indexPath.row] else { return UITableViewCell() }
        let dataGetter = { [weak dataSource] in
            return dataSource?.dataMap[field.id] as? String
        }
        let cell = field.tableView(
            tableView,
            cellForRowAt: indexPath,
            dataSetter: { [weak dataSource] data in
                dataSource?.dataMap[field.id] = data
            },
            dataGetter: dataGetter)
        if let cell = cell as? FieldTableViewCellProtocol {
            validate(cell: cell, for: field.contentType, data: dataGetter())
        }
        return cell
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let field = dataSource?.fields[safe: indexPath.row] else { return UITableView.automaticDimension }
        switch field.type {
        case .custom:
            let cField = field as? CustomField
            return cField?.delegate?.cellEstimatedHeight(
                of: tableView,
                atIndexPath: indexPath,
                withId: field.id
            ) ?? UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let field = dataSource?.fields[safe: indexPath.row] else { return UITableView.automaticDimension }
        switch field.type {
        case .custom:
            let cField = field as? CustomField
            return cField?.delegate?.cellHeight(
                of: tableView,
                atIndexPath: indexPath,
                withId: field.id
            ) ?? UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        dataSource?.header(for: section)
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        dataSource?.header(for: section)?.frame.height ?? 0
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        dataSource?.footer(for: section)
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        dataSource?.footer(for: section)?.frame.height ?? 0
    }
}

precedencegroup OptionalAssignment { associativity: right }
infix operator ?= : OptionalAssignment
func ?= <T: Any> (left: inout T, right: T?) {
    guard let right = right else { return }
    left = right
}

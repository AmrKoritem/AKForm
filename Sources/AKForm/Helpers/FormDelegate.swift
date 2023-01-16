//
//  FormDelegate.swift
//  AKForm
//
//  Created by Amr Koritem on 10/11/2022.
//

import UIKit

/// Data source of form screen.
public protocol FormDataSource: AnyObject {
    var fields: [Field] { get }
    var dataMap: [Int: Any] { get set }
    func header(for section: Int) -> UIView?
    func footer(for section: Int) -> UIView?
}

/// Delegate of form screen.
public class FormDelegate: NSObject {
    private(set) var dataSource: FormDataSource?

    init(dataSource: FormDataSource?) {
        self.dataSource = dataSource
    }
}

public extension UITableView {
    func register(fields: [Field]) {
        fields.forEach { field in
            switch field.type {
            case .text:
                registerNib(TextFieldTableViewCell.self)
            case .sheet:
                registerNib(ButtonFieldTableViewCell.self)
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

    var isDataValid: Bool {
        guard !validationStatus.values.contains(.missing),
              !validationStatus.values.contains(.invalid) else { return false }
        return true
    }

    /// Returns a boolean that determines if the fields data are valid.
    func validate() -> Bool {
        dataSource?.fields.forEach { field in
            guard dataSource?.dataMap[field.id] == nil else { return }
            dataSource?.dataMap[field.id] = ""
        }
        return isDataValid
    }
}

extension FormDelegate: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource?.fields.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let field = dataSource?.fields[safe: indexPath.row] else { return cell }
        let data = dataSource?.dataMap[field.id] as? String
        switch field.type {
        case .text:
            cell ?= tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.reuseIdentifier)
            let fieldCell = cell as? TextFieldTableViewCell
            let textField = field as? TextField
            fieldCell?.configure(
                field: field,
                textFieldText: data ?? "",
                textFieldEditingHandler: textField?.textFieldObserverHandlers?.editingHandler ?? { [weak self] text in
                    guard let text = text else { return }
                    self?.dataSource?.dataMap[field.id] = text
                },
                textFieldEditingDidEndHandler: textField?.textFieldObserverHandlers?.editingDidEndHandler ?? { _ in
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            )
        case .sheet:
            cell ?= tableView.dequeueReusableCell(withIdentifier: ButtonFieldTableViewCell.reuseIdentifier)
            let fieldCell = cell as? ButtonFieldTableViewCell
            let sheetField = field as? SheetField
            fieldCell?.configure(
                field: field,
                fieldText: data ?? "",
                buttonActionHandler: {
                    let vc = SheetViewController()
                    vc.sheetField = sheetField
                    vc.selectedOption = data != nil ? SheetOption(title: data!) : nil
                    vc.modalPresentationStyle = .overCurrentContext
                    vc.optionSelectionHandler = { [weak self, weak tableView] option in
                        self?.dataSource?.dataMap[field.id] = option?.title
                        tableView?.reloadRows(at: [indexPath], with: .automatic)
                    }
                    vc.viewDidDisappearHandler = { [weak fieldCell] in
                        fieldCell?.setStyles(with: field)
                    }
                    UIApplication.topViewController()?.present(vc, animated: true)
                }
            )
        }
        let fieldCell = cell as? FieldTableViewCellProtocol
        switch field.contentType {
        case .confirmPassword(let passwordFieldId, _):
            let passwordData = dataSource?.dataMap[passwordFieldId] as? String
            fieldCell?.validateConfirmPassword(data, passwordData: passwordData)
        default:
            fieldCell?.validate(data: data)
        }
        return cell
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

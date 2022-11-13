//
//  FormDelegate.swift
//  AKForm
//
//  Created by Amr Koritem on 10/11/2022.
//

import UIKit

/// Data source of form screen.
public protocol FormDataSource {
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
            default:
                break
            }
        }
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
        default:
            break
        }
        guard let cell = cell as? FieldTableViewCellProtocol else { return cell }
        switch data?.getValidationStatus(for: field.contentType.validationRegex) ?? .valid {
        case .invalid:
            cell.showError(message: field.errorMessages?.invalid ?? "Please enter a valid entry")
        case .missing:
            cell.showError(message: field.errorMessages?.empty ?? "Please enter your data")
        default:
            cell.clearFieldUI()
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

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
        guard let field = dataSource?.fields[safe: indexPath.row] else { return UITableViewCell() }
        switch field.type {
        case .text:
            let data = dataSource?.dataMap[field.id] as? String
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.reuseIdentifier)
            guard let cell = cell as? TextFieldTableViewCell else { return UITableViewCell() }
            cell.configure(
                field: field,
                textFieldText: data ?? "",
                textFieldEditingHandler: field.textFieldObserverHandlers?.editingHandler ?? { [weak self] text in
                    guard let text = text else { return }
                    self?.dataSource?.dataMap[field.id] = text
                },
                textFieldEditingDidEndHandler: field.textFieldObserverHandlers?.editingDidEndHandler ?? { _ in
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            )
            switch data?.getValidationStatus(for: field.contentType.validationRegex) {
            case .invalid:
                cell.showError(message: field.errorMessages?.invalid ?? "Please enter a valid entry")
            case .missing:
                cell.showError(message: field.errorMessages?.empty ?? "Please enter your data")
            default:
                cell.clearField(field.textFieldStyle.placeholderStyle)
            }
            return cell
        default:
            return UITableViewCell()
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

//
//  CustomField.swift
//  AKForm
//
//  Created by Amr Koritem on 07/03/2023.
//

import UIKit

public protocol FieldTableViewCellDelegate: AnyObject {
    func register(to tableView: UITableView)
    func cellView(of tableView: UITableView, atIndexPath indexPath: IndexPath, withId id: Int) -> UITableViewCell
    func cellHeight(of tableView: UITableView, atIndexPath indexPath: IndexPath, withId id: Int) -> CGFloat
    func cellEstimatedHeight(of tableView: UITableView, atIndexPath indexPath: IndexPath, withId id: Int) -> CGFloat
}

public extension FieldTableViewCellDelegate {
    func cellHeight(of tableView: UITableView, atIndexPath indexPath: IndexPath, withId id: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    func cellEstimatedHeight(of tableView: UITableView, atIndexPath indexPath: IndexPath, withId id: Int) -> CGFloat {
        UITableView.automaticDimension
    }
}

/// `CustomField` properties wrapper.
/// Use this class when you want a custom field cell.
public class CustomField: Field {
    public weak var delegate: FieldTableViewCellDelegate?

    /// Initializer for `CustomField`.
    /// - Parameters:
    ///   - id: Determines the id of the field.
    ///   - delegate: Custom field delegate.
    public init(id: Int, delegate: FieldTableViewCellDelegate?) {
        self.delegate = delegate
        super.init(
            id: id,
            count: .uni,
            type: .custom,
            contentType: .name,
            texts: Field.Texts(label: "", placeholder: ""),
            validationHandler: nil
        )
    }
}

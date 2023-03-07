//
//  CustomFieldsViewController.swift
//  Example
//
//  Created by Amr Koritem on 07/03/2023.
//

import UIKit
import AKForm

class CustomFieldsViewController: AKFormViewController {
    var savedDataMap: [Int: Any] = [:]

    override var fields: [Field] {
        [
            CustomField(id: 0, delegate: self),
            TextField(
                id: 1,
                contentType: .email,
                texts: Field.Texts(
                    label: "Email",
                    placeholder: "Please enter your email",
                    errorMessages: Field.ErrorMessages(
                        empty: "Please enter your email",
                        invalid: "Please enter a valid email address"
                    )
                ),
                mandatoryStyle: MandatoryStyle(isMandatory: true, position: .end)
            ),
            CustomField(id: 2, delegate: self),
            CustomField(id: 3, delegate: self)
        ]
    }

    override var dataMap: [Int: Any] {
        get {
            savedDataMap
        }
        set {
            savedDataMap = newValue
        }
    }

    override var formHeader: UIView? {
        FormHeader(text: "Custom Fields Screen")
    }

    override var formFooter: UIView? {
        FormFooter(title: "Submit") { [weak self] _ in
            guard let self = self else { return }
            guard self.validate() else { return }
            // No default validation for custom cells.
        }
    }
}

extension CustomFieldsViewController: FieldTableViewCellDelegate {
    func register(to tableView: UITableView) {
        tableView.register(UINib(nibName: "SelectValueTableViewCell", bundle: .main), forCellReuseIdentifier: "SelectValueTableViewCell")
        tableView.register(TitleSubtitleTableViewCell.self, forCellReuseIdentifier: "TitleSubtitleTableViewCell")
    }
    
    func cellView(of tableView: UITableView, atIndexPath indexPath: IndexPath, withId id: Int) -> UITableViewCell {
        guard id != 3 else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleSubtitleTableViewCell", for: indexPath)
            let tsCell = cell as? TitleSubtitleTableViewCell
            tsCell?.title = "title for id: \(id)"
            tsCell?.subtitle = "subtitle for id: \(id)"
            tsCell?.sizeToFit()
            tsCell?.layoutIfNeeded()
            return tsCell ?? cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectValueTableViewCell", for: indexPath)
        let svCell = cell as? SelectValueTableViewCell
        svCell?.configure(valueText: "\(id) cell", isValueSelected: id != 0, selectValueHandler: { _ in
            print("cell \(id) at index: \(indexPath)")
        })
        return svCell ?? cell
    }

    func cellHeight(of tableView: UITableView, atIndexPath indexPath: IndexPath, withId id: Int) -> CGFloat {
        // Declare the height for your custom cells if you want
        guard id == 3 else { return UITableView.automaticDimension }
        return 90
    }
}

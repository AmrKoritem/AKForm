//
//  FormViewController.swift
//  AKForm
//
//  Created by Amr Koritem on 10/11/2022.
//

import UIKit

open class FormViewController: AKFormViewController, FormDataSource {
    open var isFormTopConstrintToSafeArea: Bool {
        true
    }

    open var isFormBottomConstrintToSafeArea: Bool {
        true
    }

    open var formHeader: UIView? {
        nil
    }

    open var formFooter: UIView? {
        nil
    }

    public var form: UITableView?

    public lazy var formDelegate = FormDelegate(dataSource: self)

    deinit {
        removeKeyboardObservers()
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        configureForm()
    }

    public func configureForm() {
        setFormUI()
        form?.dataSource = formDelegate
        form?.delegate = formDelegate
        form?.register(fields: fields)
    }

    public func setFormUI() {
        form = UITableView()
        form?.tableHeaderView = formHeader
        form?.tableFooterView = formFooter
        form?.backgroundColor = .clear
        form?.allowsSelection = false
        form?.separatorStyle = .none
        form?.estimatedSectionHeaderHeight = 0
        if #available(iOS 15, *) {
            form?.sectionHeaderTopPadding = 0
        }
        scrollView = form
        guard let form = form else { return }
        view.addSubview(form)
        form.translatesAutoresizingMaskIntoConstraints = false
        let topAnchor = isFormTopConstrintToSafeArea ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor
        let bottomAnchor = isFormBottomConstrintToSafeArea ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor
        NSLayoutConstraint.activate([
            form.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            form.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            form.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            form.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }

    /// Returns a boolean that determines if the fields data are valid.
    public func validate() -> Bool {
        form?.reloadData()
        return formDelegate.validate()
    }

    public func reloadField(withId id: Int) {
        guard let index = fields.firstIndex(where: { $0.id == id }) else { return }
        form?.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }

    // MARK: - FormDataSource
    open var fields: [Field] {
        []
    }

    open var dataMap: [Int: Any] {
        get {
            [:]
        }
        set {
            _ = newValue
        }
    }

    open func header(for section: Int) -> UIView? {
        nil
    }

    open func footer(for section: Int) -> UIView? {
        nil
    }
}

//
//  FormViewController.swift
//  AKForm
//
//  Created by Amr Koritem on 10/11/2022.
//

import UIKit

open class FormViewController: UIViewController, FormDataSource {
    open var cancelsTouchesInView: Bool {
        false
    }

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

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureForm()
        addKeyboardObservers()
        hideKeyboardWhenTappedAround()
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
        form?.allowsSelection = false
        form?.separatorStyle = .none
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

    public func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidShow),
            name: UIResponder.keyboardDidShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidHide),
            name: UIResponder.keyboardDidHideNotification,
            object: nil)
    }

    public func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardDidShowNotification,
            object: nil)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardDidHideNotification,
            object: nil)
    }

    open func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = cancelsTouchesInView
        view.addGestureRecognizer(tap)
    }

    @objc
    public func keyboardDidShow(_ notification: Notification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        guard let keyboardSize = keyboardFrame?.cgRectValue else { return }
        form?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        form?.isScrollEnabled = true
    }

    @objc
    public func keyboardDidHide(_ notification: Notification) {
        form?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    @objc
    public func dismissKeyboard() {
        view.endEditing(true)
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

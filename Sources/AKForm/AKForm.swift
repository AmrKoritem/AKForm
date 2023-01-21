//
//  AKForm.swift
//  AKForm
//
//  Created by Amr Koritem on 10/11/2022.
//

import UIKit

public class AKForm: UIView, FormDataSource {
    public var form: UITableView?
    public var formHeader: UIView? {
        didSet {
            form?.tableHeaderView = formHeader
        }
    }
    public var formFooter: UIView? {
        didSet {
            form?.tableFooterView = formFooter
        }
    }
    public var cancelsTouchesInView = false
    public weak var dataSource: FormDataSource? {
        didSet {
            form?.register(fields: dataSource?.fields ?? [])
            form?.reloadData()
        }
    }
    public lazy var formDelegate = FormDelegate(dataSource: self)

    deinit {
        removeKeyboardObservers()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    func setUp() {
        addKeyboardObservers()
        hideKeyboardWhenTappedAround()
        setFormUI()
        form?.dataSource = formDelegate
        form?.delegate = formDelegate
        form?.register(fields: fields)
    }

    func addKeyboardObservers() {
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

    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardDidShowNotification,
            object: nil)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardDidHideNotification,
            object: nil)
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = cancelsTouchesInView
        addGestureRecognizer(tap)
    }

    func setFormUI() {
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
        guard let form = form else { return }
        embed(form)
    }

    /// Returns a boolean that determines if the fields data are valid.
    public func validate() -> Bool {
        let isValid = formDelegate.validate()
        form?.reloadData()
        return isValid
    }

    public func reloadField(withId id: Int) {
        guard let index = fields.firstIndex(where: { $0.id == id }) else { return }
        form?.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }

    @objc public func keyboardDidShow(_ notification: Notification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        guard let keyboardSize = keyboardFrame?.cgRectValue else { return }
        form?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        form?.isScrollEnabled = true
    }

    @objc public func keyboardDidHide(_ notification: Notification) {
        form?.contentInset = .zero
    }

    @objc public func dismissKeyboard() {
        endEditing(true)
    }

    // MARK: - FormDataSource
    public var fields: [Field] {
        dataSource?.fields ?? []
    }

    public var dataMap: [Int: Any] {
        get {
            dataSource?.dataMap ?? [:]
        }
        set {
            dataSource?.dataMap = newValue
        }
    }

    public func header(for section: Int) -> UIView? {
        dataSource?.header(for: section)
    }

    public func footer(for section: Int) -> UIView? {
        dataSource?.footer(for: section)
    }
}

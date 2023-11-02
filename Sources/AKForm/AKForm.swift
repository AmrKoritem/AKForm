//
//  AKForm.swift
//  AKForm
//
//  Created by Amr Koritem on 10/11/2022.
//

import UIKit

public class AKForm: UIView, FormDataSource {
    public var formTableView: UITableView?
    public var formHeader: UIView? {
        didSet {
            formTableView?.tableHeaderView = formHeader
        }
    }
    public var formFooter: UIView? {
        didSet {
            formTableView?.tableFooterView = formFooter
        }
    }
    /// Set to true to cancel tap gestures in the view controller.
    public var cancelsTouchesInViewController = false
    public weak var dataSource: FormDataSource? {
        didSet {
            formTableView?.register(fields: dataSource?.fields ?? [])
            formTableView?.reloadData()
        }
    }
    public lazy var formDelegate = FormDelegate(dataSource: self)

    /// Set this property to use a different view for snapshot security than the rest of your app.
    public var snapshotView: UIView?

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
        formTableView?.dataSource = formDelegate
        formTableView?.delegate = formDelegate
        formTableView?.register(fields: fields)
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
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willResignActive),
            name: UIApplication.willResignActiveNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
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
        NotificationCenter.default.removeObserver(
            self,
            name: UIApplication.willResignActiveNotification,
            object: nil)
        NotificationCenter.default.removeObserver(
            self,
            name: UIApplication.didBecomeActiveNotification,
            object: nil)
    }

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = cancelsTouchesInViewController
        addGestureRecognizer(tap)
    }

    func setFormUI() {
        formTableView = UITableView()
        formTableView?.tableHeaderView = formHeader
        formTableView?.tableFooterView = formFooter
        formTableView?.backgroundColor = .clear
        formTableView?.allowsSelection = false
        formTableView?.separatorStyle = .none
        formTableView?.estimatedSectionHeaderHeight = 0
        if #available(iOS 15, *) {
            formTableView?.sectionHeaderTopPadding = 0
        }
        guard let form = formTableView else { return }
        embed(form)
    }

    /// Returns a boolean that determines if the fields data are valid.
    public func validate() -> Bool {
        let isValid = formDelegate.validate()
        formTableView?.reloadData()
        return isValid
    }
    
    /// Reload a single field in the form.
    /// - Parameter id: id of the field to be reloaded.
    public func reloadField(withId id: Int) {
        guard let index = fields.firstIndex(where: { $0.id == id }) else { return }
        formTableView?.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }

    /// Called when keyboard is shown.
    @objc public func keyboardDidShow(_ notification: Notification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        guard let keyboardSize = keyboardFrame?.cgRectValue else { return }
        formTableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        formTableView?.isScrollEnabled = true
    }

    /// Called when keyboard is hidden.
    @objc public func keyboardDidHide(_ notification: Notification) {
        formTableView?.contentInset = .zero
    }

    /// Called when the keyboard is dismissed.
    @objc public func dismissKeyboard() {
        endEditing(true)
    }

    @objc func willResignActive(_ notification: Notification) {
        if let snapshotView = snapshotView {
            embed(snapshotView)
            return
        }
        guard let snapshotView = Default.Security.snapshotView else { return }
        self.snapshotView = snapshotView.exactCopy
        embed(self.snapshotView!)
    }

    @objc func didBecomeActive(_ notification: Notification) {
        guard let snapshotView = snapshotView else { return }
        snapshotView.removeFromSuperview()
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

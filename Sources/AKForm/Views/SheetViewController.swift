//
//  SheetViewController.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

class SheetViewController: UIViewController {
    var sheetField: SheetField?
    var textFieldEditingHandler: TextFieldEditingChangedHandler = { _ in }
    var textFieldEditingDidEndHandler: TextFieldEditingDidEnddHandler = { _ in }

    private lazy var header: UIView = {
        let wrapper = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 64)))
        let textField = UITextField()
        if let sheetTextFieldStyle = sheetField?.sheetTextFieldStyle {
            // TODO: - set border style
            textField.placeholder = sheetField?.placeholder
            textField.setStyle(with: sheetTextFieldStyle)
            textField.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
            textField.addTarget(self, action: #selector(textFieldChangeDidEnd(_:)), for: .editingDidEnd)
        }
        wrapper.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -20),
            textField.topAnchor.constraint(equalTo: wrapper.safeAreaLayoutGuide.topAnchor, constant: 7),
            textField.bottomAnchor.constraint(equalTo: wrapper.safeAreaLayoutGuide.bottomAnchor, constant: -7)
        ])
        wrapper.addSubview(textField)
        return wrapper
    }()

    private var sheet: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureForm()
        addKeyboardObservers()
        hideKeyboardWhenTappedAround()
    }

    func configureForm() {
        setFormUI()
        sheet?.dataSource = self
        sheet?.delegate = self
        sheet?.registerNib(OptionTableViewCell.self)
    }

    func setFormUI() {
        sheet = UITableView()
        sheet?.tableHeaderView = header
        sheet?.separatorStyle = .none
        guard let sheet = sheet else { return }
        view.addSubview(sheet)
        sheet.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sheet.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            sheet.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            sheet.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            sheet.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
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
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc
    public func keyboardDidShow(_ notification: Notification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        guard let keyboardSize = keyboardFrame?.cgRectValue else { return }
        sheet?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
    }

    @objc
    public func keyboardDidHide(_ notification: Notification) {
        sheet?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    @objc
    public func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc
    func textFieldChange(_ textField: UITextField) {
        textFieldEditingHandler(textField.text)
    }

    @objc
    func textFieldChangeDidEnd(_ textField: UITextField) {
        textFieldEditingDidEndHandler(textField.text)
    }
}

extension SheetViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sheetField?.options.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = sheetField?.options[safe: indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCell.reuseIdentifier)
        guard let fieldCell = cell as? OptionTableViewCell,
              let optionStyle = sheetField?.optionStyle else { return UITableViewCell() }
        fieldCell.configure(with: option, and: optionStyle)
        return fieldCell
    }
}

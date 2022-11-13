//
//  SheetViewController.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

class SheetViewController: UIViewController {
    var sheetField: SheetField? {
        didSet {
            textFieldEditingHandler = sheetField?.sheetTextFieldObserverHandlers?.editingHandler
            textFieldEditingDidEndHandler = sheetField?.sheetTextFieldObserverHandlers?.editingDidEndHandler
        }
    }
    var textFieldEditingHandler: TextFieldEditingChangedHandler?
    var textFieldEditingDidEndHandler: TextFieldEditingDidEnddHandler?
    var optionSelectionHandler: (String) -> Void = { _ in }

    var filteredOptions: [String] {
        let options = sheetField?.options ?? []
        guard let keyword = searchField?.text else { return options }
        return options.filter { $0.contains(keyword) }
    }

    private var sheet: UITableView?
    private var searchField: UITextField?
    private var topConstraint: NSLayoutConstraint?

    private lazy var header: UIView = {
        let wrapper = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 64)))
        let textField = UITextField()
        searchField = textField
        if let sheetTextFieldStyle = sheetField?.sheetTextFieldStyle {
            textField.placeholder = sheetField?.placeholder
            textField.setStyle(with: sheetTextFieldStyle)
            textField.stroked(
                with: sheetField?.sheetTextFieldStyle.borderStyle?.borderWidth ?? 1,
                color: sheetField?.sheetTextFieldStyle.borderStyle?.borderColor ?? .lightGray)
            textField.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
            textField.addTarget(self, action: #selector(textFieldChangeDidEnd(_:)), for: .editingDidEnd)
            textField.addTarget(self, action: #selector(returnKeyPressed(_:)), for: .primaryActionTriggered)
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

    deinit {
        removeKeyboardObservers()
        searchField?.removeTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        searchField?.removeTarget(self, action: #selector(textFieldChangeDidEnd(_:)), for: .editingDidEnd)
        searchField?.removeTarget(self, action: #selector(returnKeyPressed(_:)), for: .primaryActionTriggered)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSheet()
        addKeyboardObservers()
        guard let sheetField = sheetField else { return }
        view.backgroundColor = sheetField.sheetBackgroundColor
        view.setBorder(with: sheetField.sheetBorderStyle)
    }

    func configureSheet() {
        setSheetUI()
        sheet?.dataSource = self
        sheet?.delegate = self
        sheet?.registerNib(OptionTableViewCell.self)
    }

    func setSheetUI() {
        sheet = UITableView()
        sheet?.tableHeaderView = header
        sheet?.separatorStyle = .none
        sheet?.backgroundColor = .clear
        guard let sheet = sheet else { return }
        view.addSubview(sheet)
        sheet.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = sheet.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: view.frame.size.height * 0.35
        )
        self.topConstraint = topConstraint
        NSLayoutConstraint.activate([
            sheet.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            sheet.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            topConstraint,
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

    @objc
    func keyboardDidShow(_ notification: Notification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        guard let keyboardSize = keyboardFrame?.cgRectValue else { return }
        topConstraint?.constant -= keyboardSize.height
        sheet?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
    }

    @objc
    func keyboardDidHide(_ notification: Notification) {
        topConstraint?.constant = 0
        sheet?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    @objc
    func textFieldChange(_ textField: UITextField) {
        textFieldEditingHandler?(textField.text)
        sheet?.reloadData()
    }

    @objc
    func textFieldChangeDidEnd(_ textField: UITextField) {
        textFieldEditingDidEndHandler?(textField.text)
    }

    @objc
    func returnKeyPressed(_ textField: UITextField) {
        view.endEditing(true)
    }
}

extension SheetViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = filteredOptions[safe: indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCell.reuseIdentifier)
        guard let fieldCell = cell as? OptionTableViewCell,
              let optionStyle = sheetField?.optionStyle else { return UITableViewCell() }
        fieldCell.configure(with: option, and: optionStyle)
        return fieldCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        dismiss(animated: true)
        guard let option = filteredOptions[safe: indexPath.row] else { return }
        optionSelectionHandler(option)
    }
}

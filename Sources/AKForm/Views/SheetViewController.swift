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
            textFieldEditingHandler = sheetField?.sheetStyle.textFieldObserverHandlers?.editingHandler
            textFieldEditingDidEndHandler = sheetField?.sheetStyle.textFieldObserverHandlers?.editingDidEndHandler
        }
    }
    var selectedOption: String?
    var textFieldEditingHandler: TextFieldEditingChangedHandler?
    var textFieldEditingDidEndHandler: TextFieldEditingDidEnddHandler?
    var viewWillDisappearHandler: () -> Void = {}
    var optionSelectionHandler: (String) -> Void = { _ in }

    var filteredOptions: [String] {
        let options = sheetField?.options ?? []
        guard let keyword = searchField?.text, !keyword.isEmpty else { return options }
        return options.filter { $0.contains(keyword) }
    }

    private var sheet: UITableView?
    private var searchField: UITextField?
    private var topConstraint: NSLayoutConstraint?

    private var topSheetConstraintConstant: CGFloat {
        view.frame.size.height * (1.0 - heightCoefficient)
    }

    private lazy var heightCoefficient: CGFloat = sheetField?.sheetStyle.heightCoefficient ?? 0
    private lazy var header: UIView = {
        let wrapper = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 68)))
        let textField = UITextField()
        textField.leftPadding = Default.Dimensions.horizontalPadding
        textField.rightPadding = Default.Dimensions.horizontalPadding
        searchField = textField
        if let sheetTextFieldStyle = sheetField?.sheetStyle.textFieldStyle {
            textField.placeholder = sheetField?.placeholder
            textField.setStyle(with: sheetTextFieldStyle)
            textField.setBorder(with: sheetTextFieldStyle.borderStyle)
            textField.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
            textField.addTarget(self, action: #selector(textFieldChangeDidEnd(_:)), for: .editingDidEnd)
            textField.addTarget(self, action: #selector(returnKeyPressed(_:)), for: .primaryActionTriggered)
        }
        wrapper.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -20),
            textField.topAnchor.constraint(equalTo: wrapper.safeAreaLayoutGuide.topAnchor, constant: 9),
            textField.bottomAnchor.constraint(equalTo: wrapper.safeAreaLayoutGuide.bottomAnchor, constant: -9)
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
        dismissWhenTappedAround()
        addKeyboardObservers()
        view.backgroundColor = .clear
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearHandler()
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
        sheet?.backgroundColor = sheetField?.sheetStyle.backgroundColor
        if let sheetField = sheetField {
            sheet?.setBorder(with: sheetField.sheetStyle.borderStyle)
        }
        guard let sheet = sheet else { return }
        view.addSubview(sheet)
        sheet.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = sheet.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: topSheetConstraintConstant
        )
        self.topConstraint = topConstraint
        NSLayoutConstraint.activate([
            sheet.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            sheet.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            topConstraint,
            sheet.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }

    func dismissWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(close))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
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
        sheet?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        guard keyboardSize.height > view.frame.size.height - topSheetConstraintConstant else { return }
        let sheetHeaderHeight = sheet?.tableHeaderView?.frame.size.height ?? 0
        topConstraint?.constant = view.frame.size.height - keyboardSize.height - sheetHeaderHeight
    }

    @objc
    func keyboardDidHide(_ notification: Notification) {
        topConstraint?.constant = topSheetConstraintConstant
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

    @objc
    func close() {
        dismiss(animated: true)
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
        fieldCell.configure(with: option, and: optionStyle, isSelected: selectedOption == option)
        return fieldCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        dismiss(animated: true)
        guard let option = filteredOptions[safe: indexPath.row] else { return }
        optionSelectionHandler(option)
    }
}

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
            let textFieldObserverHandlers = sheetField?.sheetStyle.textFieldStyle?.textFieldObserverHandlers
            textFieldEditingHandler = textFieldObserverHandlers?.editingHandler
            textFieldEditingDidEndHandler = textFieldObserverHandlers?.editingDidEndHandler
        }
    }
    var selectedOption: SheetOption?
    var textFieldEditingHandler: TextFieldEditingChangedHandler?
    var textFieldEditingDidEndHandler: TextFieldEditingDidEnddHandler?
    var viewDidDisappearHandler: () -> Void = {}
    var optionSelectionHandler: (SheetOption?) -> Void = { _ in }

    var filteredOptions: [SheetOption] {
        let options = sheetField?.options ?? []
        guard let keyword = searchField?.text, !keyword.isEmpty else { return options }
        return options.filter { $0.title.contains(keyword) }
    }

    private var sheet: UITableView?
    private var topConstraint: NSLayoutConstraint?

    private var topSheetConstraintConstant: CGFloat {
        view.frame.size.height * (1.0 - heightCoefficient)
    }

    private lazy var heightCoefficient: CGFloat = sheetField?.sheetStyle.heightCoefficient ?? 0
    private lazy var headerView: UIView? = {
        let wrapperTop: CGFloat = 12
        let closeButtonHeight = closeButton?.frame.size.height ?? 0
        let textFieldTop: CGFloat = searchField == nil || closeButton == nil ? 0 : 5
        let textFieldHeight = searchField?.frame.size.height ?? 0
        let wrapperBottom: CGFloat = 9
        let wrapperHeight = wrapperTop + closeButtonHeight + textFieldTop + textFieldHeight + wrapperBottom
        let wrapper = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: wrapperHeight)))
        if let closeButton = closeButton {
            wrapper.addSubview(closeButton)
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                closeButton.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: 20),
                closeButton.topAnchor.constraint(equalTo: wrapper.safeAreaLayoutGuide.topAnchor, constant: wrapperTop),
                closeButton.heightAnchor.constraint(equalToConstant: closeButtonHeight)
            ])
        }
        guard let searchField = searchField else {
            closeButton?.bottomAnchor.constraint(equalTo: wrapper.safeAreaLayoutGuide.bottomAnchor, constant: -wrapperBottom).isActive = true
            return wrapper
        }
        wrapper.addSubview(searchField)
        searchField.translatesAutoresizingMaskIntoConstraints = false
        let fieldTop = textFieldTop == 0 ? wrapperTop : textFieldTop
        let fieldTopAnchor = closeButton?.bottomAnchor ?? wrapper.safeAreaLayoutGuide.topAnchor
        NSLayoutConstraint.activate([
            searchField.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: 20),
            searchField.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -20),
            searchField.topAnchor.constraint(equalTo: fieldTopAnchor, constant: fieldTop),
            searchField.bottomAnchor.constraint(equalTo: wrapper.safeAreaLayoutGuide.bottomAnchor, constant: -wrapperBottom)
        ])
        return wrapper
    }()
    private lazy var closeButton: UIButton? = {
        let closeButtonSide: CGFloat = 30
        let closeButton = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: closeButtonSide, height: closeButtonSide)))
        closeButton.addTarget(
            self,
            action: #selector(close),
            for: .touchUpInside
        )
        switch sheetField?.sheetStyle.closeButtonStyle {
        case .text(let attributedString):
            closeButton.setAttributedTitle(attributedString, for: .normal)
        case .icon(let image, let tintColor):
            closeButton.setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
            closeButton.imageView?.tintColor = tintColor
            closeButton.tintColor = tintColor
        default:
            return nil
        }
        return closeButton
    }()
    private lazy var searchField: UITextField? = {
        let textFieldHeight: CGFloat = 50
        guard let textFieldStyle = sheetField?.sheetStyle.textFieldStyle else { return nil }
        let textField = UITextField(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: textFieldHeight)))
        textField.setHorizontalPadding(to: Default.Dimensions.horizontalPadding)
        textField.setStyle(with: textFieldStyle)
        textField.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldChangeDidEnd(_:)), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(returnKeyPressed(_:)), for: .primaryActionTriggered)
        return textField
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
        view.backgroundColor = .clear
        guard heightCoefficient < 1.0 else { return }
        dismissWhenTappedAround()
    }

    func configureSheet() {
        setSheetUI()
        sheet?.dataSource = self
        sheet?.delegate = self
        sheet?.registerNib(OptionTableViewCell.self)
    }

    func setSheetUI() {
        sheet = UITableView()
        sheet?.tableHeaderView = headerView
        sheet?.separatorStyle = .none
        sheet?.backgroundColor = sheetField?.sheetStyle.backgroundColor
        if let sheetField = sheetField {
            sheet?.stroked(with: sheetField.sheetStyle.borderStyle)
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

    @objc func keyboardDidShow(_ notification: Notification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        guard let keyboardSize = keyboardFrame?.cgRectValue else { return }
        sheet?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        guard keyboardSize.height > view.frame.size.height - topSheetConstraintConstant else { return }
        let sheetHeaderHeight = sheet?.tableHeaderView?.frame.size.height ?? 0
        topConstraint?.constant = view.frame.size.height - keyboardSize.height - sheetHeaderHeight
    }

    @objc func keyboardDidHide(_ notification: Notification) {
        sheet?.contentInset = .zero
        topConstraint?.constant = topSheetConstraintConstant
    }

    @objc func textFieldChange(_ textField: UITextField) {
        textFieldEditingHandler?(textField.text)
        sheet?.reloadData()
    }

    @objc func textFieldChangeDidEnd(_ textField: UITextField) {
        textFieldEditingDidEndHandler?(textField.text)
    }

    @objc func returnKeyPressed(_ textField: UITextField) {
        view.endEditing(true)
    }

    @objc func close() {
        viewDidDisappearHandler()
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
        let option = filteredOptions[safe: indexPath.row]
        optionSelectionHandler(option)
        view.endEditing(true)
        dismiss(animated: true)
    }
}

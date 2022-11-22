//
//  VerificationViewController.swift
//  AKForm
//
//  Created by Amr Koritem on 21/11/2022.
//

import UIKit

open class VerificationViewController: AKFormViewController {
    open var header: UIView? {
        let wrapper = UIView()
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        wrapper.backgroundColor = .clear
        let title = UILabel()
        if let headerTitleStyle = headerTitleStyle {
            title.setStyle(with: headerTitleStyle)
        }
        wrapper.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),
            title.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: 25)
        ])
        let subtitle = UILabel()
        if let headerSubtitleStyle = headerSubtitleStyle {
            subtitle.setStyle(with: headerSubtitleStyle)
        }
        wrapper.addSubview(subtitle)
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitle.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15),
            subtitle.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: -18)
        ])
        return wrapper
    }
    open var headerTitleStyle: LabelStyle? {
        LabelStyle(attributedText: NSAttributedString(string: "title", attributes: Default.StringAttributes.label))
    }
    open var headerSubtitleStyle: LabelStyle? {
        LabelStyle(attributedText: NSAttributedString(string: "subtitle", attributes: Default.StringAttributes.label))
    }
    open var footer: UIView? {
        nil
    }

    public var fieldWidth: CGFloat {
        let totalAvailableWidth = view.frame.size.width - fieldsMinHorizaontalMargin * 2
        return totalAvailableWidth / CGFloat(fieldsCount)
    }
    private var textFields: [UITextField] {
        fieldsStack?.arrangedSubviews.compactMap { $0 as? UITextField } ?? []
    }

    open var fieldHeight: CGFloat = 65
    open var fieldStyle: FieldStyle?
    open var fieldsCount = 6
    open var fieldsMinHorizaontalMargin: CGFloat = 20
    open var countDownSeconds = 60
    open var updateTimerHandler: () -> Void = {}

    public private(set) var isTimerRunning = false

    private var timer = Timer()
    private var container: UIView?
    private var fieldsStack: UIStackView?

    deinit {
        removeKeyboardObservers()
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        runTimer()
        configureTextFields()
        addKeyboardObservers()
        hideKeyboardWhenTappedAround()
    }
    
    public func setUI() {
        addScrollView()
        addViews()
    }

    private func addScrollView() {
        scrollView = UIScrollView()
        guard let scrollView = scrollView else { return }
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.embedWithSafeArea(scrollView)
    }

    private func addViews() {
        container = UIView()
        container?.translatesAutoresizingMaskIntoConstraints = false
        container?.backgroundColor = .clear
        addHeader()
        addFieldsStack()
        addFooter()
        guard let container = container else { return }
        scrollView?.embed(container)
    }

    private func addHeader() {
        guard let container = container, let header = header else { return }
        container.addSubview(header)
        container.embedAtTop(header)
    }

    private func addFieldsStack() {
        fieldsStack = UIStackView()
        (0..<fieldsCount).forEach { [weak fieldsStack] index in
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                textField.widthAnchor.constraint(equalToConstant: fieldWidth),
                textField.heightAnchor.constraint(equalToConstant: fieldHeight),
            ])
            if let fieldStyle = fieldStyle {
                textField.setStyle(with: fieldStyle)
            }
            fieldsStack?.addArrangedSubview(textField)
        }
        guard let header = header else { return }
        fieldsStack?.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 0).isActive = true
    }

    private func addFooter() {
        guard let container = container, let footer = footer else { return }
        container.addSubview(footer)
        container.embedAtBottom(footer)
    }

    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }

    private func configureTextFields() {
        fieldsStack?.semanticContentAttribute = .forceLeftToRight
        textFields.first?.becomeFirstResponder()
        textFields.forEach { [weak self] in
            guard let self = self else {return}
            $0.delegate = self
            $0.textContentType = .oneTimeCode
            $0.keyboardType = .numberPad
        }
    }

    @objc
    private func updateTimer() {
        countDownSeconds -= countDownSeconds <= 0 ? 0:1
        updateTimerHandler()
    }
}

extension VerificationViewController: UITextFieldDelegate {
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let textFieldIndex = textFields.firstIndex(of: textField) ?? 0
        guard string.count > 0 else {
            textField.text = string
            let previousIndex = textFieldIndex - 1
            let index = previousIndex < 0 ? fieldsCount - 1 : previousIndex
            textFields[safe: index]?.becomeFirstResponder()
            return false
        }
        guard string.count == 1 else {
            let startIndex = string.startIndex
            textFields.forEach { [weak self] field in
                guard let index = self?.textFields.firstIndex(of: field) else { return }
                field.text = "\(string[string.index(startIndex, offsetBy: index)])"
            }
            return false
        }
        textField.text = string
        let nextIndex = textFieldIndex + 1
        let index = nextIndex >= fieldsCount ? 0 : nextIndex
        if index == fieldsCount - 1 {
            textFields[safe: index]?.resignFirstResponder()
        } else {
            textFields[safe: index]?.becomeFirstResponder()
        }
        return false
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textFieldIndex = textFields.firstIndex(of: textField) ?? 0
        let nextIndex = textFieldIndex + 1
        let index = nextIndex >= fieldsCount ? 0 : nextIndex
        if index == fieldsCount - 1 {
            textFields[safe: index]?.resignFirstResponder()
        } else {
            textFields[safe: index]?.becomeFirstResponder()
        }
        return true
    }
}

//
//  AKVerificationViewController.swift
//  AKForm
//
//  Created by Amr Koritem on 21/11/2022.
//

import UIKit

open class AKVerificationViewController: UIViewController {
    open var header: UIView? {
        defaultHeader
    }
    open var headerTitle: (text: String, style: LabelStyle?) {
        (text: "title", style: LabelStyle(attributes: StringAttributes.defaultLabel))
    }
    open var headerSubtitle: (text: String, style: LabelStyle?) {
        (text: "subtitle", style: LabelStyle(attributes: StringAttributes.defaultLabel))
    }
    open var footer: UIView? {
        nil
    }
    open var fieldStyle: FieldStyle? {
        FieldStyle(textAlignment: .center)
    }
    open var firstResponderFieldStyle: FieldStyle? {
        FieldStyle(textAlignment: .center)
    }
    open var fieldHeight: CGFloat {
        65
    }
    open var fieldsCount: Int {
        6
    }
    open var fieldsMinHorizaontalMargin: CGFloat {
        20
    }
    open var counterLimitInSeconds: Int {
        60
    }

    public var fieldWidth: CGFloat {
        let totalStackSpacings: CGFloat = (fieldsStack?.spacing ?? 0) * CGFloat(max(0, fieldsCount - 1))
        let totalAvailableWidth = view.frame.size.width - fieldsMinHorizaontalMargin * 2 - totalStackSpacings
        return totalAvailableWidth / CGFloat(fieldsCount)
    }
    public var otp: String {
        textFields.compactMap { $0.text }.joined()
    }
    private var textFields: [UITextField] {
        fieldsStack?.arrangedSubviews.compactMap { $0 as? UITextField } ?? []
    }

    public var scrollView: UIScrollView?
    public var cancelsTouchesInView = false
    public var updateTimerHandler: () -> Void = {}
    public lazy var counter = counterLimitInSeconds
    public private(set) var isTimerRunning = false

    lazy var defaultHeader: UIView = {
        let wrapper = UIView()
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        wrapper.backgroundColor = .clear
        let title = UILabel()
        title.attributedText = NSAttributedString(
            string: headerTitle.text,
            attributes: headerTitle.style?.attributes
        )
        wrapper.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),
            title.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: 25)
        ])
        let subtitle = UILabel()
        subtitle.attributedText = NSAttributedString(
            string: headerSubtitle.text,
            attributes: headerSubtitle.style?.attributes
        )
        wrapper.addSubview(subtitle)
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitle.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15),
            subtitle.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: -18)
        ])
        return wrapper
    }()

    private var timer = Timer()
    private var container: UIView?
    private var fieldsStack: UIStackView?

    deinit {
        removeKeyboardObservers()
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setUpKeyboard()
        runTimer()
    }
    
    public func setUI() {
        addScrollView()
        addViews()
    }

    public func runTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: (#selector(updateTimer)),
            userInfo: nil,
            repeats: true
        )
    }

    @objc public func keyboardDidShow(_ notification: Notification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        guard let keyboardSize = keyboardFrame?.cgRectValue else { return }
        scrollView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView?.isScrollEnabled = true
    }

    @objc public func keyboardDidHide(_ notification: Notification) {
        scrollView?.contentInset = .zero
    }

    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }

    func setUpKeyboard() {
        addKeyboardObservers()
        hideKeyboardWhenTappedAround()
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
        view.addGestureRecognizer(tap)
    }

    private func addScrollView() {
        scrollView = UIScrollView()
        guard let scrollView = scrollView else { return }
        view.embedWithSafeArea(scrollView)
    }

    private func addViews() {
        addContainer()
        addHeader()
        addFieldsStack()
        addFooter()
    }

    private func addContainer() {
        container = UIView()
        container?.backgroundColor = .clear
        scrollView?.embed(container!)
        container?.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }

    private func addHeader() {
        guard let header = header else { return }
        container?.embedAtTop(header)
    }

    private func addFieldsStack() {
        fieldsStack = UIStackView()
        fieldsStack?.spacing = 6
        fieldsStack?.translatesAutoresizingMaskIntoConstraints = false
        addTextFields()
        guard let fieldsStack = fieldsStack else { return }
        container?.addSubview(fieldsStack)
        guard let container = container else { return }
        fieldsStack.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        guard let header = header else {
            fieldsStack.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
            return
        }
        fieldsStack.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
    }

    private func addTextFields() {
        (0..<fieldsCount).forEach { [weak fieldsStack] _ in
            fieldsStack?.addArrangedSubview(makeTextField())
        }
        fieldsStack?.semanticContentAttribute = .forceLeftToRight
        textFields.first?.becomeFirstResponder()
    }

    private func makeTextField() -> UITextField {
        let textField = UITextField()
        textField.delegate = self
        textField.textContentType = .oneTimeCode
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalToConstant: fieldWidth),
            textField.heightAnchor.constraint(equalToConstant: fieldHeight)
        ])
        if let fieldStyle = fieldStyle {
            textField.setStyle(with: "", andStyle: fieldStyle)
        }
        return textField
    }

    private func addFooter() {
        guard let container = container else { return }
        guard let footer = footer else {
            fieldsStack?.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
            return
        }
        container.embedAtBottom(footer)
        guard let fieldsStack = fieldsStack else {
            let anchor = header?.bottomAnchor ?? container.topAnchor
            footer.topAnchor.constraint(equalTo: anchor).isActive = true
            return
        }
        footer.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor).isActive = true
    }

    @objc private func updateTimer() {
        guard counter != 0 else { return timer.invalidate() }
        counter -= counter <= 0 ? 0:1
        updateTimerHandler()
    }
}

extension AKVerificationViewController: UITextFieldDelegate {
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let textFieldIndex = textFields.firstIndex(of: textField) ?? 0
        guard string.count > 0 else {
            // count == 0 means that the back button was tapped
            textField.text = string
            let previousIndex = textFieldIndex - 1
            let index = previousIndex < 0 ? fieldsCount - 1 : previousIndex
            textFields[safe: index]?.becomeFirstResponder()
            return false
        }
        guard string.count == 1 else {
            // count > 1 means an otp input
            let startIndex = string.startIndex
            textFields.forEach { [weak self] field in
                guard let index = self?.textFields.firstIndex(of: field) else { return }
                field.text = "\(string[string.index(startIndex, offsetBy: index)])"
            }
            return false
        }
        // count == 1 means that a key button was tapped
        textField.text = string
        _ = textFieldShouldReturn(textField)
        return false
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textFieldIndex = textFields.firstIndex(of: textField) ?? 0
        let nextIndex = textFieldIndex + 1
        let index = nextIndex >= fieldsCount ? 0 : nextIndex
        if textFieldIndex == fieldsCount - 1 {
            textFields[safe: textFieldIndex]?.resignFirstResponder()
        } else {
            textFields[safe: index]?.becomeFirstResponder()
        }
        return true
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if let fieldStyle = firstResponderFieldStyle {
            textField.setStyle(with: textField.text, andStyle: fieldStyle)
        }
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        if let fieldStyle = fieldStyle {
            textField.setStyle(with: textField.text, andStyle: fieldStyle)
        }
    }
}

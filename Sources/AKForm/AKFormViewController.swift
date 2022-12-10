//
//  AKFormViewController.swift
//  AKForm
//
//  Created by Amr Koritem on 22/11/2022.
//

import UIKit

open class AKFormViewController: UIViewController {
    open var cancelsTouchesInView: Bool {
        false
    }

    public var scrollView: UIScrollView?

    deinit {
        removeKeyboardObservers()
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addKeyboardObservers()
        hideKeyboardWhenTappedAround()
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
        scrollView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView?.isScrollEnabled = true
    }

    @objc
    public func keyboardDidHide(_ notification: Notification) {
        scrollView?.contentInset = .zero
    }

    @objc
    public func dismissKeyboard() {
        view.endEditing(true)
    }
}

//
//  AKFormViewController.swift
//  AKForm
//
//  Created by Amr Koritem on 22/11/2022.
//

import UIKit

open class AKFormViewController: UIViewController, FormDataSource {
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

    public var akform = AKForm()

    var quickFormDataSource: QuickFormDataSource?

    public convenience init(quickDataSource: QuickFormDataSource?) {
        self.init()
        quickFormDataSource = quickDataSource
    }

    public convenience init(
        fields: [Field],
        initialDataMap: [Int: Any] = [:],
        header: UIView? = nil,
        footer: UIView? = nil
    ) {
        self.init()
        quickFormDataSource = QuickFormDataSource(
            fields: fields,
            initialDataMap: initialDataMap,
            header: header,
            footer: footer
        )
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        configureForm()
    }

    public func configureForm() {
        view.addSubview(akform)
        akform.translatesAutoresizingMaskIntoConstraints = false
        let topAnchor = isFormTopConstrintToSafeArea ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor
        let bottomAnchor = isFormBottomConstrintToSafeArea ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor
        NSLayoutConstraint.activate([
            akform.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            akform.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            akform.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            akform.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        akform.formHeader = quickFormDataSource?.header ?? formHeader
        akform.formFooter = quickFormDataSource?.footer ?? formFooter
        akform.dataSource = self
    }

    /// Returns a boolean that determines if the fields data are valid.
    public func validate() -> Bool {
        let isValid = akform.validate()
        akform.form?.reloadData()
        return isValid
    }

    public func reloadField(withId id: Int) {
        guard let index = fields.firstIndex(where: { $0.id == id }) else { return }
        akform.form?.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }

    // MARK: - FormDataSource
    open var fields: [Field] {
        quickFormDataSource?.fields ?? []
    }

    open var dataMap: [Int: Any] {
        get {
            quickFormDataSource?.dataMap ?? [:]
        }
        set {
            quickFormDataSource?.dataMap = newValue
        }
    }

    open func header(for section: Int) -> UIView? {
        nil
    }

    open func footer(for section: Int) -> UIView? {
        nil
    }
}

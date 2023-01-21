//
//  FormFooter.swift
//  Sportfy-Partner
//
//  Created by Amr Koritem on 22/11/2022.
//

import UIKit

class FormFooter: UIView {
    init(title: String?, handler: @escaping UIActionHandler) {
        super.init(frame: .zero)
        setUp(title: title, handler: handler)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    func setUp(title: String? = nil, handler: @escaping UIActionHandler = { _ in }) {
        let top: CGFloat = 15
        let bottom: CGFloat = 15
        let footer = UIButton(primaryAction: UIAction(title: title ?? "Button", handler: handler))
        footer.sizeToFit()
        frame = CGRect(origin: .zero, size: CGSize(width: 100, height: top + footer.frame.size.height + bottom))
        backgroundColor = .clear
        addSubview(footer)
        footer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            footer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            footer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            footer.topAnchor.constraint(equalTo: topAnchor, constant: top),
            footer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottom)
        ])
    }
}

//
//  FormHeader.swift
//  Sportfy-Partner
//
//  Created by Amr Koritem on 21/11/2022.
//

import UIKit

class FormHeader: UIView {
    private let topConstraint: CGFloat = 15
    private let bottomConstraint: CGFloat = 15

    init(text: String) {
        super.init(frame: .zero)
        setUp(text: text)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    func setUp(text: String? = nil) {
        let header = UILabel()
        header.text = text
        header.font = .boldSystemFont(ofSize: 22)
        header.sizeToFit()
        let height = topConstraint + header.frame.size.height + bottomConstraint
        frame = CGRect(origin: .zero, size: CGSize(width: 100, height: height))
        backgroundColor = .clear
        addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            header.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            header.topAnchor.constraint(equalTo: topAnchor, constant: topConstraint),
            header.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomConstraint)
        ])
    }
}

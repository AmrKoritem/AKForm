//
//  VerificationViewController.swift
//  Example
//
//  Created by Amr Koritem on 18/01/2023.
//

import UIKit
import AKForm

class VerificationViewController: AKVerificationViewController {
    override var headerTitle: (text: String, style: LabelStyle?) {
        (
            text: "Check your email",
            style: LabelStyle(
                font: .boldSystemFont(ofSize: 18),
                textColor: .black,
                textAlignment: .center)
        )
    }

    override var headerSubtitle: (text: String, style: LabelStyle?) {
        (
            text: "A verification code was sent to your email",
            style: LabelStyle(
                font: .systemFont(ofSize: 16),
                textColor: .darkGray,
                textAlignment: .center)
        )
    }

    override var footer: UIView? {
        let footer = UIView(
            frame: CGRect(
                origin: .zero,
                size: CGSize(
                    width: view.frame.size.width,
                    height: 200
                )
            )
        )
        footer.backgroundColor = .clear
        footer.translatesAutoresizingMaskIntoConstraints = false
        footer.addSubview(footerTimerLabel)
        footerTimerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            footerTimerLabel.centerXAnchor.constraint(equalTo: footer.centerXAnchor),
            footerTimerLabel.topAnchor.constraint(equalTo: footer.topAnchor, constant: 15),
        ])
        let button = FormFooter(title: "Submit") { _ in
            // Do action
        }
        footer.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: footer.centerXAnchor),
            button.topAnchor.constraint(equalTo: footerTimerLabel.bottomAnchor, constant: 25),
            button.bottomAnchor.constraint(equalTo: footer.bottomAnchor, constant: 25),
        ])
        return footer
    }

    override var fieldStyle: FieldStyle? {
        FieldStyle(
            font: .systemFont(ofSize: 14),
            textAlignment: .center,
            backgroundColor: .white,
            borderStyle: BorderStyle(color: .lightGray),
            shadowStyle: ShadowStyle(
                color: .black.withAlphaComponent(0.15),
                radius: 2,
                offset: CGSize(width: 0, height: 4),
                opacity: 1
            )
        )
    }

    override var firstResponderFieldStyle: FieldStyle? {
        FieldStyle(
            font: .systemFont(ofSize: 14),
            textAlignment: .center,
            backgroundColor: .white,
            borderStyle: BorderStyle(color: .blue),
            shadowStyle: ShadowStyle(
                color: .black.withAlphaComponent(0.15),
                radius: 2,
                offset: CGSize(width: 0, height: 4),
                opacity: 1
            )
        )
    }

    override var counterLimitInSeconds: Int {
        40
    }

    lazy var footerTimerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Waiting time = \(counterLimitInSeconds)"
        label.sizeToFit()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        navigationItem.title = "Verification Screen"
        view.backgroundColor = .white
        updateTimerHandler = { [weak self] in
            self?.footerTimerLabel.text = "Waiting time = \(self?.counter ?? 0)"
            self?.footerTimerLabel.sizeToFit()
        }
    }
}

//
//  TitleSubtitleTableViewCell.swift
//  Example
//
//  Created by Amr Koritem on 07/03/2023.
//

import UIKit

class TitleSubtitleTableViewCell: UITableViewCell {
    var title = "Title" {
        didSet {
            titleLabel.text = title
        }
    }

    var subtitle = "My awesome subtitle" {
        didSet {
            subtitleLabel.text = subtitle
        }
    }

    private lazy var titleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 50))
        view.backgroundColor = .darkGray
        return view
    }()

    private lazy var lineView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 3))
        view.backgroundColor = .red
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = title
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .cyan
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.text = subtitle
        return label
    }()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    func configure() -> Void {
        backgroundColor = .lightGray
        addSubview(titleView)
        titleView.addSubview(titleLabel)
        titleView.addSubview(lineView)
        addSubview(subtitleLabel)
        positionSubviews()
    }

    private func positionSubviews() -> Void {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: topAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            lineView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 3)
        ])
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 8.0),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8.0),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16)
        ])
    }
}

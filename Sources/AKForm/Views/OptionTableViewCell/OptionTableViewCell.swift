//
//  OptionTableViewCell.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

class OptionTableViewCell: UITableViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var secondaryImageView: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var secondaryImageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondaryImageCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondaryImageTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var startInsetConstraint: NSLayoutConstraint!
    @IBOutlet weak var separatorHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var endInsetConstraint: NSLayoutConstraint!

    var optionStyle: OptionStyle?

    func configure(with option: SheetOption?, and optionStyle: OptionStyle, isSelected: Bool) {
        titleLabel.text = option?.title
        titleLabel.textColor = optionStyle.titleColor
        titleLabel.font = optionStyle.titleFont
        titleLabel.textAlignment = optionStyle.titleTextAlignment
        subtitleLabel.text = option?.subtitle
        subtitleLabel.textColor = optionStyle.subtitleColor
        subtitleLabel.font = optionStyle.subtitleFont
        subtitleLabel.textAlignment = optionStyle.subtitleTextAlignment
        mainImageView.image = option?.mainImage
        secondaryImageView.image = option?.secondaryImage
        self.optionStyle = optionStyle
        separatorView.isHidden = optionStyle.separatorStyle.color == .clear
        separatorView.backgroundColor = optionStyle.separatorStyle.color
        startInsetConstraint.constant = optionStyle.separatorStyle.startInset
        separatorHeightConstraint.constant = optionStyle.separatorStyle.thickness
        endInsetConstraint.constant = optionStyle.separatorStyle.endInset
        configureSelection(isSelected: isSelected)
    }

    func configureSelection(isSelected: Bool) {
        guard let optionStyle = optionStyle else { return }
        guard isSelected else {
            titleLabel.textColor = optionStyle.titleColor
            contentView.backgroundColor = optionStyle.backgroundColor
            return
        }
        switch optionStyle.selectionStyle {
        case .backgroundColor, .labelColor, .symbol:
            setSelectionStyle(with: optionStyle.selectionStyle)
        case .custom(let styles):
            styles.forEach { setSelectionStyle(with: $0) }
        default:
            break
        }
    }

    private func setSelectionStyle(with style: OptionStyle.SelectionStyle) {
        switch style {
        case .backgroundColor(let color):
            contentView.backgroundColor = color
        case .labelColor(let color):
            titleLabel.textColor = color
        case .symbol(let image, let position):
            let imageView = UIImageView(image: image)
            switch position {
            case .start:
                titleStackView.insertArrangedSubview(imageView, at: 0)
            case .end:
                titleStackView.addArrangedSubview(imageView)
            case .lineEnd(let endMargin):
                secondaryImageView.image = image
                secondaryImageCenterConstraint.priority = .defaultLow
                secondaryImageTopConstraint.priority = .required
                secondaryImageTrailingConstraint.constant = endMargin
            }
        default:
            // .none is not considered since it doesn't do anything
            // .custom is not considered to avoid redundancy
            break
        }
    }
}

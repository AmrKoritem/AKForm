//
//  OptionTableViewCell.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

class OptionTableViewCell: UITableViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var secondaryImageView: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var startInsetConstraint: NSLayoutConstraint!
    @IBOutlet weak var separatorHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var endInsetConstraint: NSLayoutConstraint!

    func configure(with option: String?, and optionStyle: OptionStyle) {
        titleLabel.text = option
        titleLabel.textColor = optionStyle.textColor
        titleLabel.font = optionStyle.font
        titleLabel.textAlignment = optionStyle.textAlignment
        contentView.backgroundColor = optionStyle.backgroundColor
        separatorView.isHidden = optionStyle.separatorStyle.color == .clear
        separatorView.backgroundColor = optionStyle.separatorStyle.color
        startInsetConstraint.constant = optionStyle.separatorStyle.startInset
        separatorHeightConstraint.constant = optionStyle.separatorStyle.thickness
        endInsetConstraint.constant = optionStyle.separatorStyle.endInset
    }
}

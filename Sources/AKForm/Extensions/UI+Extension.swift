//
//  UI+Extension.swift
//  SportfyApp
//
//  Created by Ahmed Abaza on 10/03/2022.
//

import UIKit

extension NSAttributedString {
    static func defaultPlaceholder(_ placeholder: String) -> NSAttributedString {
        NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
            ]
        )
    }

    static func errorPlaceholder(_ placeholder: String) -> NSAttributedString {
        NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.red,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
            ]
        )
    }
}

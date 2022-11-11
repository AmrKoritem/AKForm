//
//  UI+Extension.swift
//  SportfyApp
//
//  Created by Ahmed Abaza on 10/03/2022.
//

import UIKit

extension UIView {
    /// Strokes the view with the given line width and color.
    ///  - Returns: The view.
    @discardableResult func stroked(with borderWidth: CGFloat = 1.0, color borderColor: UIColor) -> Self {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        return self
    }
}

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

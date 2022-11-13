//
//  UIView+Extension.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
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

    func setBorder(with borderStyle: FieldBorderStyle) {
        stroked(with: borderStyle.borderWidth, color: borderStyle.borderColor)
        clipsToBounds = true
        layer.cornerRadius = borderStyle.cornerRadius
    }
}

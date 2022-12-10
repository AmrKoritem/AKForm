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

    /// Strokes the view with the given borderStyle.
    ///  - Returns: The view.
    @discardableResult func stroked(with borderStyle: BorderStyle) -> Self {
        stroked(with: borderStyle.thickness, color: borderStyle.color)
        clipsToBounds = true
        layer.cornerRadius = borderStyle.cornerRadius
        return self
    }

    /// Shadows the view with the given parameters.
    ///  - Returns: The view.
    @discardableResult func shadowed(with color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) -> Self {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
        return self
    }

    /// Shadows the view with the given shadowStyle.
    ///  - Returns: The view.
    @discardableResult func shadowed(with shadowStyle: ShadowStyle) -> Self {
        return shadowed(
            with: shadowStyle.color,
            radius: shadowStyle.radius,
            offset: shadowStyle.offset,
            opacity: shadowStyle.opacity
        )
    }

    @discardableResult func shadowRemoved() -> Self {
        layer.shadowColor = UIColor.clear.cgColor
        return self
    }

    func embed(_ view: UIView) {
        addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func embedWithSafeArea(_ view: UIView) {
        addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    func embedAtTop(_ view: UIView) {
        addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func embedAtBottom(_ view: UIView) {
        addSubview(view)
        NSLayoutConstraint.activate([
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

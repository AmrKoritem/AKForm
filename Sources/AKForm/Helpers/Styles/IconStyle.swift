//
//  IconStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 19/11/2022.
//

import UIKit

/// Determine field icon ui attributes.
public struct IconStyle {
    let icon: (image: UIImage, tint: UIColor?)
    let marginToEdge: CGFloat
    let action: (target: Any?, selector: Selector)?
    
    /// Initializer for `IconStyle`.
    /// - Parameters:
    ///   - icon: Icon image and tint. If tint color is not provided, then the image is shown with original rendering.
    ///   - marginToEdge: Icon margin.
    ///   - action: Icon tap action.
    public init(
        icon: (image: UIImage, tint: UIColor?),
        marginToEdge: CGFloat = Default.Dimensions.iconToEdge,
        action: (target: Any?, selector: Selector)? = nil
    ) {
        self.icon = icon
        self.marginToEdge = marginToEdge
        self.action = action
    }

    func getIconContainerView(iconViewSize: CGSize, isLeft: Bool) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: iconViewSize.height),
            containerView.widthAnchor.constraint(equalToConstant: iconViewSize.width + marginToEdge)
        ])
        let iconViewFrame = CGRect(origin: CGPoint(x: isLeft ? marginToEdge : 0, y: 0), size: iconViewSize)
        let image = icon.image.withRenderingMode(icon.tint == nil ? .alwaysOriginal : .alwaysTemplate)
        if let action = action {
            let iconView = UIButton(frame: iconViewFrame)
            iconView.addTarget(
                action.target,
                action: action.selector,
                for: .touchUpInside
            )
            iconView.imageView?.tintColor = icon.tint
            iconView.setImage(image, for: .normal)
            containerView.addSubview(iconView)
        } else {
            let iconView = UIImageView(frame: iconViewFrame)
            iconView.tintColor = icon.tint
            iconView.image = image
            containerView.addSubview(iconView)
        }
        return containerView
    }
}

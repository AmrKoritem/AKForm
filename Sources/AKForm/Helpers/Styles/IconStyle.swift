//
//  IconStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 19/11/2022.
//

import UIKit

/// Determine field icon ui attributes.
public struct IconStyle {
    let icon: UIImage
    let marginToEdge: CGFloat
    let action: (target: Any?, selector: Selector)?
    
    /// Initializer for `IconStyle`.
    /// - Parameters:
    ///   - icon: Icon image.
    ///   - marginToEdge: Icon margin.
    ///   - action: Icon tap action.
    public init(
        icon: UIImage,
        marginToEdge: CGFloat = Default.Dimensions.fieldIconEdgeMargin,
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
        if let action = action {
            let iconView = UIButton(frame: iconViewFrame)
            iconView.addTarget(
                action.target,
                action: action.selector,
                for: .touchUpInside
            )
            iconView.setImage(icon, for: .normal)
            containerView.addSubview(iconView)
        } else {
            let iconView = UIImageView(frame: iconViewFrame)
            iconView.image = icon
            containerView.addSubview(iconView)
        }
        return containerView
    }
}

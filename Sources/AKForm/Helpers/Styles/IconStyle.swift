//
//  IconStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 19/11/2022.
//

import UIKit

public struct IconStyle {
    let icon: UIImage
    /// For this property, .end and .lineEnd yield the same result.
    let position: SymbolPosition
    let marginToEdge: CGFloat
    let action: (target: Any?, selector: Selector)?

    public init(
        icon: UIImage,
        position: SymbolPosition = .end,
        marginToEdge: CGFloat = Default.Dimensions.fieldIconEdgeMargin,
        action: (target: Any?, selector: Selector)? = nil
    ) {
        self.icon = icon
        self.position = position
        self.marginToEdge = marginToEdge
        self.action = action
    }

    func getIconContainerView(width: CGFloat, height: CGFloat) -> UIView {
        let containerView: UIView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: width + marginToEdge,
                height: height
            )
        )
        let iconViewFrame = CGRect(x: marginToEdge, y: 0, width: width, height: height)
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

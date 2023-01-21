//
//  ShadowStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 21/11/2022.
//

import UIKit

/// Used to determine the shadow ui attributes for a view.
public struct ShadowStyle {
    let color: UIColor
    let radius: CGFloat
    let offset: CGSize
    let opacity: Float
    
    /// Initializer for `ShadowStyle`.
    /// - Parameters:
    ///   - color: Shadow color.
    ///   - radius: Shadow radius.
    ///   - offset: Shadow offset.
    ///   - opacity: Shadow opacity.
    public init(
        color: UIColor,
        radius: CGFloat,
        offset: CGSize,
        opacity: Float
    ) {
        self.color = color
        self.radius = radius
        self.offset = offset
        self.opacity = opacity
    }
}

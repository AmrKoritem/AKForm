//
//  ShadowStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 21/11/2022.
//

import UIKit

public struct ShadowStyle {
    let color: UIColor
    let radius: CGFloat
    let offset: CGSize
    let opacity: Float

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

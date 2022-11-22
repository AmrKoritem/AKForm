//
//  BorderStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public struct BorderStyle {
    let color: UIColor
    let thickness: CGFloat
    let cornerRadius: CGFloat

    public init(
        color: UIColor = Default.Colors.border,
        thickness: CGFloat = Default.Dimensions.borderWidth,
        cornerRadius: CGFloat = Default.Dimensions.cornerRadius
    ) {
        self.color = color
        self.thickness = thickness
        self.cornerRadius = cornerRadius
    }
}

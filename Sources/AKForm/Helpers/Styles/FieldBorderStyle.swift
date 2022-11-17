//
//  FieldBorderStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public struct FieldBorderStyle {
    let borderColor: UIColor
    let borderWidth: CGFloat
    let cornerRadius: CGFloat

    public init(
        borderColor: UIColor = Default.Colors.border,
        borderWidth: CGFloat = Default.Dimensions.borderWidth,
        cornerRadius: CGFloat = Default.Dimensions.cornerRadius
    ) {
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
    }
}

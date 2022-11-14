//
//  SeparatorStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public struct SeparatorStyle {
    var color: UIColor
    var thickness: CGFloat
    var startInset: CGFloat
    var endInset: CGFloat

    public init(
        color: UIColor = Default.Colors.separator,
        dimension: CGFloat = Default.Dimensions.separatorThickness,
        startInset: CGFloat = Default.Dimensions.separatorStartInset,
        endInset: CGFloat = Default.Dimensions.separatorEndInset
    ) {
        self.color = color
        self.thickness = dimension
        self.startInset = startInset
        self.endInset = endInset
    }
}

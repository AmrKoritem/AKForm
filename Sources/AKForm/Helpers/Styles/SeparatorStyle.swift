//
//  SeparatorStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// Determine cells separator ui attributes.
public struct SeparatorStyle {
    let color: UIColor
    let thickness: CGFloat
    let startInset: CGFloat
    let endInset: CGFloat
    
    /// Initializer for `SeparatorStyle`.
    /// - Parameters:
    ///   - color: Separator color.
    ///   - thickness: Separator thickness.
    ///   - startInset: Separator start inset.
    ///   - endInset: Separator end inset.
    public init(
        color: UIColor = Default.Colors.separator,
        thickness: CGFloat = Default.Dimensions.separatorThickness,
        startInset: CGFloat = Default.Dimensions.separatorStartInset,
        endInset: CGFloat = Default.Dimensions.separatorEndInset
    ) {
        self.color = color
        self.thickness = thickness
        self.startInset = startInset
        self.endInset = endInset
    }
}

//
//  SeparatorStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public struct SeparatorStyle {
    public static let defaultColor: UIColor = .lightGray

    var color: UIColor
    var dimension: CGFloat
    var startInset: CGFloat
    var endInset: CGFloat

    public init(
        color: UIColor = SeparatorStyle.defaultColor,
        dimension: CGFloat = 1,
        startInset: CGFloat = 0,
        endInset: CGFloat = 0
    ) {
        self.color = color
        self.dimension = dimension
        self.startInset = startInset
        self.endInset = endInset
    }
}

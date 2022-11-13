//
//  FieldBorderStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

public struct FieldBorderStyle {
    var borderColor: UIColor
    var borderWidth: CGFloat
    var cornerRadius: CGFloat

    public init(borderColor: UIColor = .lightGray, borderWidth: CGFloat = 1, cornerRadius: CGFloat = 14) {
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
    }
}

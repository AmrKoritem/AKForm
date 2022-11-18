//
//  SheetStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 18/11/2022.
//

import UIKit

public struct SheetStyle {
    public typealias TextFieldStyle = (
        withTextField: Bool,
        fieldStyle: FieldStyle,
        textFieldObserverHandlers: TextFieldObserverHandlers?
    )
    let backgroundColor: UIColor
    let borderStyle: FieldBorderStyle
    let textFieldStyle: TextFieldStyle?
    let heightCoefficient: CGFloat

    public init(
        backgroundColor: UIColor = Default.Colors.sheetBackground,
        borderStyle: FieldBorderStyle = FieldBorderStyle(borderColor: Default.Colors.sheetBorder),
        textFieldStyle: TextFieldStyle? = nil,
        heightCoefficient: CGFloat = 0.35
    ) {
        self.backgroundColor = backgroundColor
        self.borderStyle = borderStyle
        self.textFieldStyle = textFieldStyle
        self.heightCoefficient = heightCoefficient
    }
}

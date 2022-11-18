//
//  SheetStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 18/11/2022.
//

import UIKit

public struct SheetStyle {
    let backgroundColor: UIColor
    let borderStyle: FieldBorderStyle
    let textFieldStyle: FieldStyle
    let textFieldObserverHandlers: TextFieldObserverHandlers?
    let heightCoefficient: CGFloat

    public init(
        backgroundColor: UIColor = Default.Colors.sheetBackground,
        borderStyle: FieldBorderStyle = FieldBorderStyle(borderColor: Default.Colors.sheetBorder),
        textFieldStyle: FieldStyle = FieldStyle(),
        textFieldObserverHandlers: TextFieldObserverHandlers? = nil,
        heightCoefficient: CGFloat = 0.35
    ) {
        self.backgroundColor = backgroundColor
        self.borderStyle = borderStyle
        self.textFieldStyle = textFieldStyle
        self.textFieldObserverHandlers = textFieldObserverHandlers
        self.heightCoefficient = heightCoefficient
    }
}

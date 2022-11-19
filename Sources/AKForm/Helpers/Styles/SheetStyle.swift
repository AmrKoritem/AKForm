//
//  SheetStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 18/11/2022.
//

import UIKit

public struct SheetStyle {
    public enum CloseButtonStyle {
        case text(attributedString: NSAttributedString)
        case icon(image: UIImage?, tintColor: UIColor)
        case none
    }
    public typealias TextFieldStyle = (
        fieldStyle: FieldStyle,
        placeholder: String?,
        textFieldObserverHandlers: TextFieldObserverHandlers?
    )
    let backgroundColor: UIColor
    let borderStyle: FieldBorderStyle
    let textFieldStyle: TextFieldStyle?
    let heightCoefficient: CGFloat
    let closeButtonStyle: CloseButtonStyle

    public init(
        backgroundColor: UIColor = Default.Colors.sheetBackground,
        borderStyle: FieldBorderStyle = FieldBorderStyle(borderColor: Default.Colors.sheetBorder),
        textFieldStyle: TextFieldStyle? = nil,
        heightCoefficient: CGFloat = 0.35,
        closeButtonStyle: CloseButtonStyle = .none
    ) {
        self.backgroundColor = backgroundColor
        self.borderStyle = borderStyle
        self.textFieldStyle = textFieldStyle
        self.heightCoefficient = heightCoefficient
        self.closeButtonStyle = closeButtonStyle
    }
}

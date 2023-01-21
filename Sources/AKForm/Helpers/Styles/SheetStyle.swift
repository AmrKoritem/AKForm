//
//  SheetStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 18/11/2022.
//

import UIKit

/// Used to determine sheet ui attributes.
public struct SheetStyle {
    /// Used to determine the close button ui.
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
    let borderStyle: BorderStyle
    let textFieldStyle: TextFieldStyle?
    let heightCoefficient: CGFloat
    let closeButtonStyle: CloseButtonStyle
    
    /// Initializer for `SheetStyle`.
    /// - Parameters:
    ///   - backgroundColor: Sheet background color.
    ///   - borderStyle: Sheet border style.
    ///   - textFieldStyle: Sheet text field style.
    ///   - heightCoefficient: Sheet height compared to the height of the screen behind it. This coefficient value is between 0.0 and 1.0.
    ///   - closeButtonStyle: Sheet close button style.
    public init(
        backgroundColor: UIColor = Default.Colors.sheetBackground,
        borderStyle: BorderStyle = BorderStyle(color: Default.Colors.sheetBorder),
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

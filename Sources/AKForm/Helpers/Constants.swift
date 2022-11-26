//
//  Constants.swift
//  AKForm
//
//  Created by Amr Koritem on 14/11/2022.
//

import UIKit

public struct Default {
    public static var isMandatory: Bool = false

    public struct Strings {
        public static var mandatorySymbol: String = "*"
        public static var errorMessageEmpty: String = "Please enter your data"
        public static var errorMessageInvalid: String = "Please enter a valid entry"
    }

    public struct Fonts {
        public static var label: UIFont = .systemFont(ofSize: 18)
        public static var field: UIFont = .systemFont(ofSize: 16)
        public static var placeholder: UIFont = .systemFont(ofSize: 16)
        public static var error: UIFont = .systemFont(ofSize: 14)
        public static var optionTitle: UIFont = .systemFont(ofSize: 18)
        public static var optionSubtitle: UIFont = .systemFont(ofSize: 14)
        public static var mandatory: UIFont = .systemFont(ofSize: 18)
    }

    public struct Dimensions {
        public static var borderWidth: CGFloat = 1
        public static var cornerRadius: CGFloat = 14
        public static var sheetBorderWidth: CGFloat = 1
        public static var sheetCornerRadius: CGFloat = 14
        public static var separatorStartInset: CGFloat = 1
        public static var separatorThickness: CGFloat = 1
        public static var separatorEndInset: CGFloat = 1
        public static var horizontalPadding: CGFloat = 8
        public static var fieldIconEdgeMargin: CGFloat = 18
    }

    public struct Colors {
        /// black
        public static var label: UIColor = .black
        /// black
        public static var field: UIColor = .black
        /// light gray
        public static var placeholder: UIColor = .lightGray
        /// light gray
        public static var border: UIColor = .lightGray
        /// white
        public static var background: UIColor = .white
        /// system red
        public static var errorBorder: UIColor = .systemRed
        /// system red
        public static var errorLabel: UIColor = .systemRed
        /// light gray
        public static var sheetBorder: UIColor = .lightGray
        /// white
        public static var sheetBackground: UIColor = .white
        /// black
        public static var optionTitle: UIColor = .black
        /// light gray
        public static var optionSubtitle: UIColor = .lightGray
        /// transparent
        public static var optionBackground: UIColor = .clear
        /// light gray
        public static var separator: UIColor = .lightGray
        /// orangy red
        public static var mandatory: UIColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
    }

    struct StringAttributes {
        static let label = [
            NSAttributedString.Key.foregroundColor: Default.Colors.label,
            NSAttributedString.Key.font: Default.Fonts.label
        ]
        static let placeholder = [
            NSAttributedString.Key.foregroundColor: Default.Colors.placeholder,
            NSAttributedString.Key.font: Default.Fonts.placeholder
        ]
        static func from(color: UIColor?, font: UIFont?) -> [NSAttributedString.Key: Any] {
            [
                NSAttributedString.Key.foregroundColor: color ?? Default.Colors.label,
                NSAttributedString.Key.font: font ?? Default.Fonts.label
            ]
        }
    }
}

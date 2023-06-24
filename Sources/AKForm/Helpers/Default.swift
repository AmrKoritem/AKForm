//
//  Default.swift
//  AKForm
//
//  Created by Amr Koritem on 14/11/2022.
//

import UIKit

/// Global default values.
public struct Default {
    /// Determines if it's mandatory to fill all fields.
    public static var isMandatory: Bool = false
    /// Determines the selection style of sheet options.
    public static var optionSelectionStyle = OptionStyle.SelectionStyle.none
    /// Determines the selection style of fields.
    public static var firstResponderStyle: FirstResponderStyle?
    /// Use it to secure all your forms. Only AK views will be affected by the non-nil options of this property.
    public static var security = Security()

    /// Strings.
    public struct Strings {
        /// Mandatory symbol.
        public static var mandatorySymbol: String = "*"
        /// Empty error message.
        public static var errorMessageEmpty: String = "Please enter your data"
        /// Invalid error message.
        public static var errorMessageInvalid: String = "Please enter a valid entry"
    }

    /// Fonts.
    public struct Fonts {
        /// system 18
        public static var label: UIFont = .systemFont(ofSize: 18)
        /// system 16
        public static var field: UIFont = .systemFont(ofSize: 16)
        /// system 16
        public static var placeholder: UIFont = .systemFont(ofSize: 16)
        /// system 14
        public static var error: UIFont = .systemFont(ofSize: 14)
        /// system 18
        public static var optionTitle: UIFont = .systemFont(ofSize: 18)
        /// system 14
        public static var optionSubtitle: UIFont = .systemFont(ofSize: 14)
        /// system 18
        public static var mandatory: UIFont = .systemFont(ofSize: 18)
    }

    /// Dimensions.
    public struct Dimensions {
        /// CGFloat: 1.0
        public static var borderWidth: CGFloat = 1
        /// CGFloat: 14.0
        public static var cornerRadius: CGFloat = 14
        /// CGFloat: 1.0
        public static var sheetBorderWidth: CGFloat = 1
        /// CGFloat: 14.0
        public static var sheetCornerRadius: CGFloat = 14
        /// CGFloat: 1.0
        public static var separatorStartInset: CGFloat = 1
        /// CGFloat: 1.0
        public static var separatorThickness: CGFloat = 1
        /// CGFloat: 1.0
        public static var separatorEndInset: CGFloat = 1
        /// CGFloat: 8.0
        public static var horizontalPadding: CGFloat = 8
        /// CGFloat: 18.0
        public static var fieldIconEdgeMargin: CGFloat = 18
    }

    /// Colors.
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
        /// orangy red -> rgb(235, 87, 87)
        public static var mandatory: UIColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
    }
}

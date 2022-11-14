//
//  Constants.swift
//  AKForm
//
//  Created by Amr Koritem on 14/11/2022.
//

import UIKit

public struct Default {
    public struct Fonts {
        public static var label: UIFont = .systemFont(ofSize: 18)
        public static var field: UIFont = .systemFont(ofSize: 18)
        public static var placeholder: UIFont = .systemFont(ofSize: 18)
        public static var error: UIFont = .systemFont(ofSize: 16)
        public static var optionTitle: UIFont = .systemFont(ofSize: 16)
        public static var optionSubtitle: UIFont = .systemFont(ofSize: 14)
    }

    public struct Dimensions {
        public static var borderWidth: CGFloat = 1
        public static var cornerRadius: CGFloat = 14
        public static var sheetBorderWidth: CGFloat = 1
        public static var sheetCornerRadius: CGFloat = 14
        public static var separatorThickness: CGFloat = 14
        public static var separatorStartInset: CGFloat = 14
        public static var separatorEndInset: CGFloat = 14
    }

    public struct Colors {
        public static var label: UIColor = .black
        public static var field: UIColor = .black
        public static var placeholder: UIColor = .lightGray
        public static var border: UIColor = .lightGray
        public static var background: UIColor = .white
        public static var errorBorder: UIColor = .systemRed
        public static var errorLabel: UIColor = .systemRed
        public static var sheetBorder: UIColor = .lightGray
        public static var sheetBackground: UIColor = .white
        public static var optionTitle: UIColor = .black
        public static var optionSubtitle: UIColor = .lightGray
        public static var optionBackground: UIColor = .clear
        public static var separator: UIColor = .lightGray
    }
}

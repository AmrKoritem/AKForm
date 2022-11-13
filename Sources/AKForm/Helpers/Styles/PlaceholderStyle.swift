//
//  PlaceholderStyle.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

/// Used to set placeholders.
public struct PlaceholderStyle {
    var text: String?
    var attributedText: NSAttributedString?

    public init(attributedText: NSAttributedString) {
        self.attributedText = attributedText
    }

    public init(text: String) {
        self.text = text
    }
}

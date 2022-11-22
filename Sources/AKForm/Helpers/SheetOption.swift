//
//  SheetOption.swift
//  AKForm
//
//  Created by Amr Koritem on 22/11/2022.
//

import UIKit

public struct SheetOption: Equatable {
    public static func == (lhs: SheetOption, rhs: SheetOption) -> Bool {
        lhs.title == rhs.title
    }

    let title: String
    let subtitle: String?
    let mainImage: UIImage?
    let secondaryImage: UIImage?

    public init(
        title: String,
        subtitle: String? = nil,
        mainImage: UIImage? = nil,
        secondaryImage: UIImage? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.mainImage = mainImage
        self.secondaryImage = secondaryImage
    }
}

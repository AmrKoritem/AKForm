//
//  QuickFormDataSource.swift
//  AKForm
//
//  Created by Amr Koritem on 19/03/2023.
//

import UIKit

/// Fast-use version for form screen data source.
public struct QuickFormDataSource {
    /// Form fields.
    let fields: [Field]
    /// Form data filled by the user.
    public var dataMap: [Int: Any]
    /// Form header view.
    let header: UIView?
    /// Form footer view.
    let footer: UIView?

    public init(fields: [Field], dataMap: [Int: Any], header: UIView?, footer: UIView?) {
        self.fields = fields
        self.dataMap = dataMap
        self.header = header
        self.footer = footer
    }
}

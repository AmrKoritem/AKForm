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
    var dataMap: [Int: Any]
    /// Form header view.
    let header: UIView?
    /// Form footer view.
    let footer: UIView?

    public init(fields: [Field], initialDataMap: [Int: Any] = [:], header: UIView? = nil, footer: UIView? = nil) {
        self.fields = fields
        self.dataMap = initialDataMap
        self.header = header
        self.footer = footer
    }

    public func getDataAt(id: Int) -> Any? {
        dataMap[id]
    }

    public mutating func setData(_ data: Any, at id: Int) {
        dataMap[id] = data
    }
}

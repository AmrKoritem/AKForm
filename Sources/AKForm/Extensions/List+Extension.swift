//
//  List+Extension.swift
//  AKForm
//
//  Created by Amr Koritem on 10/11/2022.
//

import UIKit

extension UITableView {
    func registerNib<T: UITableViewCell>(_ tableViewCell: T.Type) {
        register(UINib(nibName: T.nibName, bundle: .main), forCellReuseIdentifier: T.reuseIdentifier)
    }
}

extension UIView {
    static var nibName: String {
        String(describing: self)
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

extension MutableCollection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        get {
            indices.contains(index) ? self[index] : nil
        }
        set {
            guard let newValue = newValue, indices.contains(index) else { return }
            self[index] = newValue
        }
    }
}

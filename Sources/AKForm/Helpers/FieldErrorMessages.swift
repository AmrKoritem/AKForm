//
//  FieldErrorMessages.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import Foundation

public struct FieldErrorMessages {
    var empty: String
    var invalid: String

    public init(empty: String, invalid: String) {
        self.empty = empty
        self.invalid = invalid
    }

    public func message(for validationStatus: String.ValidationStatus) -> String {
        switch validationStatus {
        case .missing:
            return empty
        case .invalid:
            return invalid
        case .valid:
            return ""
        }
    }
}

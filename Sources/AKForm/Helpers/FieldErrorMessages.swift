//
//  FieldErrorMessages.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import Foundation

extension Field {
    /// Field errors holder.
    public struct ErrorMessages {
        var empty: String
        var invalid: String
        
        /// Initializer for `Field.ErrorMessages`.
        /// - Parameters:
        ///   - empty: Empty error message.
        ///   - invalid: Invalid error message.
        public init(empty: String, invalid: String) {
            self.empty = empty
            self.invalid = invalid
        }
        
        /// Method returning the error message according to the validation status provided.
        /// - Parameter validationStatus: Field validation status.
        /// - Returns: Error message.
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
}

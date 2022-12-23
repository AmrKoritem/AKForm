//
//  FieldTexts.swift
//  AKForm
//
//  Created by Amr Koritem on 24/12/2022.
//

import Foundation

extension Field {
    /// Field meta data holder.
    public struct Texts {
        let label: String
        let placeholder: String
        let errorMessages: ErrorMessages

        public init(label: String, placeholder: String, errorMessages: ErrorMessages? = nil) {
            self.label = label
            self.placeholder = placeholder
            self.errorMessages = errorMessages ?? ErrorMessages(
                empty: Default.Strings.errorMessageEmpty,
                invalid: Default.Strings.errorMessageInvalid
            )
        }
    }
}

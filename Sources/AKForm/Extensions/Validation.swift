//
//  Validation.swift
//  AKForm
//
//  Created by Amr Koritem on 10/11/2022.
//

import UIKit

extension String {
    enum ValidationRegex: String {
        case name = "^[\u{0600}-\u{065F}\u{066A}-\u{06EF}\u{06FA}-\u{06FF}a-zA-Z0-9 ]{2,}$"
        case password = "^.{8,}$"
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case youtubeVideo = """
        ^((?:https?:)?\\/\\/)?((?:www|m)\\.)?((?:youtube\\.com|youtu.be))
        (\\/(?:[\\w\\-]+\\?v=|embed\\/|v\\/)?)([\\w\\-]+)(\\S+)$
        """
        case url = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        case none = ""
    }

    public enum ValidationStatus {
        case valid
        case invalid
        case missing
    }

    func isValid(_ regex: ValidationRegex) -> Bool {
        isValid(regex.rawValue)
    }

    func isValid(_ regex: String) -> Bool {
        getValidationStatus(for: regex) == .valid
    }

    func getValidationStatus(for regex: ValidationRegex) -> ValidationStatus {
        getValidationStatus(for: regex.rawValue)
    }

    func getValidationStatus(for regex: String) -> ValidationStatus {
        guard !regex.isEmpty else { return .valid }
        let isValid = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
        guard !isEmpty else { return .missing }
        return isValid ? .valid : .invalid
    }
}

extension UITextInput {
    func hasValid(_ regex: String.ValidationRegex) -> Bool {
        hasValid(regex.rawValue)
    }

    func hasValid(_ regex: String) -> Bool {
        guard let textRange = textRange(from: beginningOfDocument, to: endOfDocument) else { return false }
        return text(in: textRange)?.isValid(regex) ?? false
    }
}

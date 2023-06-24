//
//  Security.swift
//  AKForm
//
//  Created by Amr Koritem on 24/06/2023.
//

import UIKit

/// Used to determine the wanted level of security. Security options with nil value will not be activated.
public struct Security {
    public var pasteboard: UIPasteboard?

    public init(pasteboard: UIPasteboard? = nil) {
        self.pasteboard = pasteboard
    }
}

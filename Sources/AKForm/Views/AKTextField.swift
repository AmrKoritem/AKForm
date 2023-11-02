//
//  AKTextField.swift
//  AKForm
//
//  Created by Amr Koritem on 24/06/2023.
//

import UIKit

public class AKTextField: UITextField {
    public override func copy(_ sender: Any?) {
        guard let securePasteboard = Default.Security.pasteboard, let range = selectedTextRange else {
            super.copy(sender)
            return
        }
        securePasteboard.string = text(in: range)
    }

    public override func cut(_ sender: Any?) {
        guard let securePasteboard = Default.Security.pasteboard,
              let range = selectedTextRange,
              let position = selectedTextPosition else {
            super.cut(sender)
            return
        }
        securePasteboard.string = text(in: range)
        text?.removeSubrange(position)
        sendActions(for: .editingChanged)
    }

    public override func paste(_ sender: Any?) {
        guard let securePasteboard = Default.Security.pasteboard else {
            super.paste(sender)
            return
        }
        guard let position = selectedTextPosition else {
            text = securePasteboard.string
            return
        }
        text?.replaceSubrange(position, with: securePasteboard.string ?? "")
        sendActions(for: .editingChanged)
    }
}

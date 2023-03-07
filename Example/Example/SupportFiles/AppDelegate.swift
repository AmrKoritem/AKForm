//
//  AppDelegate.swift
//  Example
//
//  Created by Amr Koritem on 09/09/2022.
//

import UIKit
import AKForm

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Default.Fonts.label = .systemFont(ofSize: 16)
        Default.Colors.label = .black
        Default.Fonts.field = .systemFont(ofSize: 16)
        Default.Colors.field = .black
        Default.optionSelectionStyle = .backgroundColor(color: .blue.withAlphaComponent(0.25))
        Default.firstResponderStyle = {
            let fieldStyle = FieldStyle(borderStyle: BorderStyle(color: .blue))
            return (labelStyle: nil, fieldStyle: fieldStyle, mandatoryStyle: nil)
        }
        return true
    }
}


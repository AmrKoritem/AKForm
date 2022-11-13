//
//  UIApplication+Extension.swift
//  AKForm
//
//  Created by Amr Koritem on 13/11/2022.
//

import UIKit

extension UIApplication {
    static var rootWindow: UIWindow? {
        guard #available(iOS 13, *) else {
            return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        }
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }

    class func topViewController(
        controller: UIViewController? = UIApplication.rootWindow?.rootViewController
    ) -> UIViewController? {
        switch controller {
        case is UINavigationController:
            return topViewController(controller: (controller as? UINavigationController)?.visibleViewController)
        case is UITabBarController:
            return topViewController(controller: (controller as? UITabBarController)?.selectedViewController)
        default:
            return controller?.presentedViewController ?? controller
        }
    }
}

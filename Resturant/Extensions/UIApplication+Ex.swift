//
//  UIApplication+Ex.swift
//
//  Created by Abed Qassim on 10/10/20.
//

import UIKit
public extension UIApplication {
    var topViewController: UIViewController? {
        guard var topViewController = UIApplication.shared.windows.first?.rootViewController else { return nil }

        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        return topViewController
    }

    var topNavigationController: UINavigationController? {
        return topViewController as? UINavigationController
    }
}

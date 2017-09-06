//
//  ApplicationDelegate.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit
import Overlog

/// Entry point for the application.
@UIApplicationMain fileprivate final class ApplicationDelegate: UIResponder, UIApplicationDelegate {

	// MARK: Properties

	/// - SeeAlso: UIApplicationDelegate.window
	@objc(window) fileprivate lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    var overlog: Overlog?
    
	// MARK: UIApplicationDelegate

	/// - SeeAlso: UIApplicationDelegate.application(_:didFinishLaunchingWithOptions:)
	fileprivate func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController(rootViewController: ViewController())
        
        overlog = Overlog.shared
        overlog?.show(in: window!, rootViewController: navigationController)
        overlog?.toggleOnShakeGesture = true

        window?.makeKeyAndVisible()
        
		return true
	}

}

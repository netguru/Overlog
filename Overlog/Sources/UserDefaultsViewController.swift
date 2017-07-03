//
//  UserDefaultsViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class UserDefaultsViewController: UIViewController {

    /// Custom view to be displayed
    internal let customView = UserDefaultsView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        view = customView
    }
}

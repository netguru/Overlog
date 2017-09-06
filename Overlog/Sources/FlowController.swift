//
//  FlowController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

protocol FlowController {
    
    associatedtype ViewController: UIViewController
    
    /// The root view controller of current flow
    weak var rootViewController: ViewController? { get }
}

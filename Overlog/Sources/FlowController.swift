//
// FlowController.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

protocol FlowController {
    
    /// A navigation controller responsible for handling the flow
    weak var navigationController: UINavigationController? { get }
}

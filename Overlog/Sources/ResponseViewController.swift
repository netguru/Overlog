//
//  ResponseViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class ResponseViewController: UIViewController {

    /// Respoonse view to be displayed
    internal let customView = ResponseView()

    /// networkTrafficEntry instance
    fileprivate let networkTrafficEntry: NetworkTrafficEntry

    /// Initialize the instance
    ///
    /// - Parameter networkTrafficEntry: networkTrafficEntry instance
    init(networkTrafficEntry: NetworkTrafficEntry) {
        self.networkTrafficEntry = networkTrafficEntry
        super.init(nibName: nil, bundle: nil)
        prepareView()
    }

    internal override func viewDidLoad() {
        super.viewDidLoad()
    }

    internal override func loadView() {
        view = customView
    }

    @available(*, unavailable, message: "Use init(networkTraffic:) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ResponseViewController {
    func prepareView() {
        if let response = networkTrafficEntry.response {
            customView.deserializedBodyLabel.text =  "Body:\n \(response.deserializedBody ?? "Empty")"
            customView.headersLabel.text = "Headers:\n\(String(describing: response.headers))"
            customView.statusCodeLabel.text = "  Status code: \(String(describing: response.statusCode))  "
            customView.statusCodeLabel.backgroundColor = .green
        }

        if let error = networkTrafficEntry.error {
            customView.deserializedBodyLabel.text =  "Info:\n \(error.userInfo)"
            customView.headersLabel.text = "Domain:\n\(error.domain)\nReason:\n\(error.reason)"
            customView.statusCodeLabel.text = "  Error code: \(String(describing: error.code))  "
            customView.statusCodeLabel.backgroundColor = .red
        }
    }
}

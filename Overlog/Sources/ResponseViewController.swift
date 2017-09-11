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

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Use init(networkTraffic:) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal override func loadView() {
        view = customView
    }

    internal func displayResponse(from entry: NetworkTrafficEntry) {
        if let response = entry.response {
            customView.deserializedBodyLabel.text =  "Body:\n \(response.deserializedBody ?? "Empty")"
            customView.headersLabel.text = "Headers:\n\(String(describing: response.headers))"
            customView.statusCodeLabel.text = "  Status code: \(String(describing: response.statusCode))  "
            customView.statusCodeLabel.backgroundColor = .green
        }

        if let error = entry.error {
            customView.deserializedBodyLabel.text =  "Info:\n \(error.userInfo)"
            customView.headersLabel.text = "Domain:\n\(error.domain)\nReason:\n\(error.reason)"
            customView.statusCodeLabel.text = "  Error code: \(String(describing: error.code))  "
            customView.statusCodeLabel.backgroundColor = .red
        }
    }
}

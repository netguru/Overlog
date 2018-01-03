//
//  RequestViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class RequestViewController: UIViewController {

    /// Request view to be displayed
    private let customView = RequestView()

    internal override func loadView() {
        view = customView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Use init() instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal func displayRequest(from entry: NetworkTrafficEntry) {
        customView.urlView.valueLabel.text = entry.request.urlString
        customView.methodView.valueLabel.text = entry.request.method
        customView.headersView.valueLabel.text = String(describing: entry.request.headers)
        customView.bodyView.valueLabel.text = entry.request.deserializedBody ?? "<empty>"
    }
}

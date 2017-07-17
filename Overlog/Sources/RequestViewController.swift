//
//  RequestViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit
import ResponseDetective

internal final class RequestViewController: UIViewController {

    /// Request view to be displayed
    let customView = RequestView()

    /// networkRequest instance to be used
    let networkRequest: RequestRepresentation

    /// Initialize the instance
    ///
    /// - Parameter networkRequest: NetworkRequest instance
    init(networkRequest: RequestRepresentation) {
        self.networkRequest = networkRequest
        super.init(nibName: nil, bundle: nil)
        prepareView()
    }

    internal override func viewDidLoad() {
        super.viewDidLoad()
    }

    internal override func loadView() {
        view = customView
    }

    @available(*, unavailable, message: "Use init(networkRequest:) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RequestViewController {
    fileprivate func prepareView() {
        customView.deserializedBodyLabel.text = "Body:\n\(networkRequest.deserializedBody ?? "Empty")"
        customView.headersLabel.text = "Headers:\n\(String(describing: networkRequest.headers))"
        customView.methodLabel.text = "  Method: \(networkRequest.method)  "
        customView.urlLabel.text = "URL: \(networkRequest.urlString)"
    }
}

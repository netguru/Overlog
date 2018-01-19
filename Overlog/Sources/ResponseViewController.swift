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

    @available(*, unavailable, message: "Use init() instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal override func loadView() {
        super.loadView()
        view.addSubview(customView)
        customView.pinToSuperviewEdges()
    }

    internal func displayResponse(from entry: NetworkTrafficEntry) {
        if let response = entry.response {
            customView.statusView.valueLabel.text = entry.statusCodeWithTextRepresentation.uppercased()
            customView.statusView.valueBackground.backgroundColor = entry.responsedWithSuccess ? .OVLStatusGreen : .OVLStatusRed
            
            customView.firstRow.keyLabel.text = "Headers".localized
            customView.firstRow.valueLabel.text = response.headers.keyValueString ?? "<empty>"
            
            customView.secondRow.keyLabel.text = "Body".localized
            customView.secondRow.valueLabel.text = response.deserializedBody ?? "<empty>"
            
            customView.thirdRow.isHidden = true
        } else if let error = entry.error {
            customView.statusView.valueLabel.text = "CONNECTION ERROR".localized
            customView.statusView.valueBackground.backgroundColor = .OVLStatusRed
            
            customView.firstRow.keyLabel.text = "Error".localized
            customView.firstRow.valueLabel.text = "\(error.domain) \(String(describing: error.code))"
            
            customView.secondRow.keyLabel.text = "Reason".localized
            customView.secondRow.valueLabel.text = error.reason
            
            customView.thirdRow.isHidden = false
            customView.thirdRow.keyLabel.text = "User Info".localized
            customView.thirdRow.valueLabel.text = error.userInfo.isEmpty ? "<empty>" : String(describing: error.userInfo)
        }
    }
}

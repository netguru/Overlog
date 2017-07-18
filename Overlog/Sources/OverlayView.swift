//
// OverlayView.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

internal final class OverlayView: View {
    
    internal let containerView = UIView()
    internal let floatingButton = UIButton(type: .system)

    override func setupHierarchy() {
        [containerView, floatingButton].forEach { addSubview($0) }
    }

    override func setupProperties() {

        floatingButton.setTitle("Overlog", for: .normal)

        floatingButton.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        floatingButton.layer.cornerRadius = 30.0
        floatingButton.backgroundColor = UIColor(colorLiteralRed: 66/255.0, green: 146/255.0, blue: 244/255.0, alpha: 1.0)
        floatingButton.layer.shadowColor = UIColor.black.cgColor
        floatingButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        floatingButton.layer.shadowRadius = 7.0
        floatingButton.layer.shadowOpacity = 0.2

        floatingButton.setTitleColor(.white, for: .normal)
    }
    
    /// Embed a view into container view and setup its autoresizing masks.
    ///
    /// - Parameter view: view to be embedded.
    internal func embed(view: UIView) {
        
        containerView.addSubview(view)
        view.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin]
    }

    internal func animateTitleChange(with newTitle: String, duration numberOfSeconds: TimeInterval) {
        self.floatingButton.setTitle(newTitle, for: .normal)
    }

    override func setupConstraints() {
        
        containerView.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth, .flexibleHeight]
    }
}

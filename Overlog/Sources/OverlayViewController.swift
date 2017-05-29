//
// OverlayViewController.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

internal final class OverlayViewController: UIViewController {
    
    var didTapFloatingButton: ((UIButton) -> Void)? = nil
    
    let overlayView = OverlayView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = overlayView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overlayView.floatingButton.addTarget(self, action: #selector(didTapFloatingButton(button:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OverlayViewController {
    
    @objc func didTapFloatingButton(button: UIButton) {
        didTapFloatingButton?(button)
    }
    
}

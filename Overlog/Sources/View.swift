//
//  View.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

internal class View: UIView {

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        setupProperties()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Abstract

    /// Sets up the properties of `self`. Called automatically on `init()`.
    internal func setupProperties() {
        // no-op by default
    }

    /// Sets up the view hierarchy of `self`. Called automatically on `init()`.
    internal func setupHierarchy() {
        // no-op by default
    }

    /// Sets up layout constraints in `self`. Called automatically on `init()`.
    internal func setupConstraints() {
        // no-op by default
    }

    @available(*, unavailable, message: "Use init() instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

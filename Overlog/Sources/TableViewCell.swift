//
//  TableViewCell.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

/// Base class for all UITableViewCells.
internal class TableViewCell: UITableViewCell {

    /// Initialize the receiver
    ///
    /// - Parameters:
    ///   - style: UITableViewCellStyle
    ///   - reuseIdentifier: reuseIdentifier
    internal override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

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

    @available(*, unavailable, message: "Use init(style:reuseIdentifier) instead")
    required internal init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

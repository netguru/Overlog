//
//  SettingsTableViewCell.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal protocol SettingsTableViewCellDelegate: class {
    
    /// Tells the receiver that an action was triggered by given control instance.
    ///
    /// - Parameters:
    ///   - tableViewCell: a table view cell containing the sender.
    ///   - control: a control instance responsible for triggering the action.
    func tableViewCell(_ tableViewCell: SettingsTableViewCell, didPerformActionWith control: UIControl)
}

final internal class SettingsTableViewCell: UITableViewCell {
    
    /// A switch instance responsible for changing value described by the cell
    let toggle = UISwitch()
    
    /// A delegate object responsible for receiving callbacks from cell instance
    weak var delegate: SettingsTableViewCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryView = toggle
        toggle.addTarget(self, action: #selector(didChangeValue(for:)), for: .valueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension SettingsTableViewCell {
    
    @objc fileprivate func didChangeValue(for toggle: UISwitch) {
        delegate?.tableViewCell(self, didPerformActionWith: toggle)
    }
}

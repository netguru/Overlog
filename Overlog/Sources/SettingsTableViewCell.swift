//
//  SettingsTableViewCell.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

internal protocol SettingsTableViewCellDelegate: class {
    func tableViewCell(_ tableViewCell: SettingsTableViewCell, didPerformActionWith control: UIControl)
}

final internal class SettingsTableViewCell: UITableViewCell {
    
    let toggle = UISwitch()
    
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

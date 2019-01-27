//
//  OverlogView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class MainView: View {

    internal let tableView = UITableView(frame: .zero)
    internal let headerView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 220))
    internal let logoImageView = UIImageView(image: .init(namedInOverlogBundle: "overlog-logo"))
    internal let footerLabel = UILabel(frame: .zero)

    override func setupHierarchy() {
        [tableView, footerLabel].forEach { addSubview($0) }
        headerView.addSubview(logoImageView)
    }

    override func setupProperties() {
        [logoImageView, tableView, footerLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        backgroundColor = .OVLDarkBlue
        
        tableView.bounces = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear

        /// To hide empty cells
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView(frame: .zero)

        headerView.backgroundColor = .OVLDarkBlue
        
        footerLabel.attributedText = footerAttributedText
        footerLabel.textAlignment = .center
        footerLabel.backgroundColor = .OVLDarkBlue
    }

    override func setupConstraints() {
        tableView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        if #available(iOS 9.0, *) {
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.topAnchor.constraint(equalTo: topAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: footerLabel.topAnchor),
                
                logoImageView.heightAnchor.constraint(equalToConstant: 100),
                logoImageView.widthAnchor.constraint(equalToConstant: 100),
                logoImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                logoImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -20),
                
                footerLabel.heightAnchor.constraint(equalToConstant: 80),
                footerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                footerLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor),
                footerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                footerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        } else {
            var allConstraints = [NSLayoutConstraint]()
            
            let views = [
                "tableView": tableView,
                "logoImageView": logoImageView,
                "footerLabel": footerLabel,
                "headerView": headerView
            ]
            
            let logoVerticalSizeConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:[logoImageView(100)]",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += logoVerticalSizeConstraint
            
            let logoHorizontalSizeConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:[logoImageView(100)]",
                options: [.alignAllCenterY],
                metrics: nil,
                views: views
            )
            allConstraints += logoHorizontalSizeConstraint
            
            let logoCenterConstraints = [
                NSLayoutConstraint.init(
                    item: logoImageView,
                    attribute: .centerX,
                    relatedBy: .equal,
                    toItem: headerView,
                    attribute: .centerX,
                    multiplier: 1,
                    constant: 0
                ),
                NSLayoutConstraint.init(
                    item: logoImageView,
                    attribute: .centerY,
                    relatedBy: .equal,
                    toItem: headerView,
                    attribute: .centerY,
                    multiplier: 1,
                    constant: -20
                )
            ]
            allConstraints += logoCenterConstraints
        
            let verticalPositionsConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-(-8)-[tableView]-[footerLabel(80)]-(-8)-|",
                options: [.alignAllCenterX],
                metrics: nil,
                views: views
            )
            allConstraints += verticalPositionsConstraint
            
            let tableViewHorizontalPositionConstraint = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-(-8)-[tableView]-(-8)-|",
                options: [],
                metrics: nil,
                views: views
            )
            allConstraints += tableViewHorizontalPositionConstraint
            
            NSLayoutConstraint.activate(allConstraints)
        }
    }
    
    private lazy var footerAttributedText: NSAttributedString = {
        let love: String
        if #available(iOS 10.0, *) {
            love = "♥"
        } else {
            love = "💙"
        }
        let netguru = "Netguru"
        let text = "With \(love) from \(netguru)"
        let attributedString = NSMutableAttributedString(string: text)
        
        /// Common attributes
        let commonAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.OVLLightGray,
            NSAttributedString.Key.font: UIFont.OVLFont(ofSize: 16, weight: .regular)
        ]
        
        /// Attributes for heart and Netguru text
        let blueBiggerFontAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.OVLLightBlue,
            NSAttributedString.Key.font: UIFont.OVLFont(ofSize: 16, weight: .bold)
        ]
        
        attributedString.addAttributes(
            commonAttributes,
            range: NSRange(location: 0, length: attributedString.length)
        )
        
        /// Blue color for heart
        guard let heartRange = text.range(of: love) else { return attributedString }
        attributedString.addAttributes(
            blueBiggerFontAttributes,
            range: NSRange(heartRange, in: text)
        )
        
        /// Blue color for Netguru
        guard let netguruRange = text.range(of: netguru) else { return attributedString }
        attributedString.addAttributes(
            blueBiggerFontAttributes,
            range: NSRange(netguruRange, in: text)
        )
        
        return attributedString
    }()

}

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

        floatingButton.layer.cornerRadius = 30.0
        floatingButton.backgroundColor = UIColor(colorLiteralRed: 66/255.0, green: 146/255.0, blue: 244/255.0, alpha: 1.0)
        floatingButton.layer.shadowColor = UIColor.black.cgColor
        floatingButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        floatingButton.layer.shadowRadius = 7.0
        floatingButton.layer.shadowOpacity = 0.2

        floatingButton.setTitleColor(.white, for: .normal)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
    }


    /// Embed a view into container view and setup its constraints.
    ///
    /// - Parameter view: view to be embedded.
    internal func embed(view: UIView) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(view)
        
        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                view.topAnchor.constraint(equalTo: containerView.topAnchor),
                view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            ])
        } else {
            let views = [
                "view": view,
            ]
            
            containerView.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "H:|[view]|",
                    options: .alignAllTop,
                    metrics: nil,
                    views: views
                )
            )
            
            containerView.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|[view]|",
                    options: .alignAllTop,
                    metrics: nil,
                    views: views
                )
            )

        }
        
    }
    
    override func setupConstraints() {
        
        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
                containerView.topAnchor.constraint(equalTo: topAnchor),
                containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
                containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
                floatingButton.widthAnchor.constraint(equalToConstant: 60),
                floatingButton.heightAnchor.constraint(equalToConstant: 60),
                floatingButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                floatingButton.topAnchor.constraint(equalTo: topAnchor)
            ])
        } else {
            let views = [
                "floatingButton": floatingButton,
                "containerView": containerView
            ]
            
            addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "H:|[containerView]|",
                    options: .alignAllTop,
                    metrics: nil,
                    views: views
                )
            )
            
            addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|[containerView]|",
                    options: .alignAllTop,
                    metrics: nil,
                    views: views
                )
            )
            
            addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|[floatingButton]",
                    options: .alignAllTop,
                    metrics: nil,
                    views: views
                )
            )
            addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "H:[floatingButton]|",
                    options: .alignAllTop,
                    metrics: nil,
                    views: views
                )
            )
            addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "[floatingButton(60)]",
                    options: .alignAllTop,
                    metrics: nil,
                    views: views
                )
            )
            addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "V:[floatingButton(60)]",
                    options: .alignAllTop,
                    metrics: nil,
                    views: views
                )
            )
        }
        
    }
    
}

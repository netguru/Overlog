//
// OverlayView.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

internal final class OverlayView: UIView {
    
    let floatingButton = UIButton(type: .system)
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(floatingButton)
        floatingButton.setTitle("Overlog", for: .normal)
        
        floatingButton.layer.cornerRadius = 30.0
        floatingButton.backgroundColor = UIColor(colorLiteralRed: 66/255.0, green: 146/255.0, blue: 244/255.0, alpha: 1.0)
        floatingButton.layer.shadowColor = UIColor.black.cgColor
        floatingButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        floatingButton.layer.shadowRadius = 7.0
        floatingButton.layer.shadowOpacity = 0.2
        
        floatingButton.setTitleColor(.white, for: .normal)
        
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        
        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                floatingButton.widthAnchor.constraint(equalToConstant: 60),
                floatingButton.heightAnchor.constraint(equalToConstant: 60),
                floatingButton.topAnchor.constraint(equalTo: topAnchor),
                floatingButton.leadingAnchor.constraint(equalTo: leadingAnchor)
            ])
        } else {
            let views = [
                "floatingButton": floatingButton,
            ]
            
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
                    withVisualFormat: "H:|[floatingButton]",
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

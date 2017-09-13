//
//  OverlayView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class OverlayView: View {
    
    internal let containerView = UIView()
    internal let floatingButton = UIButton(type: .system)
    private var floatingButtonTilteChangeTask: DispatchWorkItem?

    override func setupHierarchy() {
        [containerView, floatingButton].forEach { addSubview($0) }
    }

    override func setupProperties() {
        floatingButton.setTitle("Overlog", for: .normal)
        floatingButton.setTitleColor(.white, for: .normal)
        floatingButton.layer.cornerRadius = 30.0
        floatingButton.layer.shadowColor = UIColor.black.cgColor
        floatingButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        floatingButton.layer.shadowRadius = 7.0
        floatingButton.layer.shadowOpacity = 0.2
        floatingButton.backgroundColor = UIColor(colorLiteralRed: 66/255.0, green: 146/255.0, blue: 244/255.0, alpha: 1.0)
        floatingButton.frame = CGRect(x: 0, y: 0, width: 60, height: 60)

        containerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bringFloatingButtonToFrontIfNeeded()
        floatingButton.frame = framePreventingFloatingButtonToMoveOutOfScreen()
    }

    override func setupConstraints() {
        if #available(iOSApplicationExtension 9.0, *) {
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: bottomAnchor),
                containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
                containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
                containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        } else {
            // Fallback on earlier versions
        }
    }

    /// Animates floating button's title.
    ///
    /// - Parameters:
    ///   - fromTitle: Title of the button which appear on the animation's beginning.
    ///   - toTitle: Title of the button to show when animation ends.
    ///   - numberOfSeconds: duration of animation in seconds.
    internal func animateTitleChange(from fromTitle: String, to toTitle: String = "Overlog", duration numberOfSeconds: Int) {
        if let task = self.floatingButtonTilteChangeTask {
            task.cancel()
        }
        floatingButtonTilteChangeTask = nil
        floatingButton.setTitle(fromTitle, for: .normal)

        let task = DispatchWorkItem { [weak self] in
            self?.floatingButton.setTitle(toTitle, for: .normal)
            self?.floatingButtonTilteChangeTask = nil
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(numberOfSeconds), execute: task)
        self.floatingButtonTilteChangeTask = task
    }

    /// Calculates floating button's frame after device's rotation.
    /// It prevents against moving button outside of the screen.
    ///
    /// - Returns: New frame to be applied to floating button.
    fileprivate func framePreventingFloatingButtonToMoveOutOfScreen() -> CGRect {
        var origin: CGPoint?

        if floatingButton.frame.maxX > frame.maxX {
            origin = CGPoint(x: frame.maxX - floatingButton.frame.width, y: floatingButton.frame.origin.y)
        }

        if floatingButton.frame.maxY > frame.maxY {
            origin = CGPoint(x: floatingButton.frame.origin.x, y: frame.maxY - floatingButton.frame.height)
        }

        return origin != nil ? CGRect(origin: origin!, size: floatingButton.bounds.size) : floatingButton.frame
    }

    /// Moves button to the front in the view hierarchy.
    fileprivate func bringFloatingButtonToFrontIfNeeded() {
        if subviews.last !== floatingButton {
            bringSubview(toFront: floatingButton)
        }
    }
}

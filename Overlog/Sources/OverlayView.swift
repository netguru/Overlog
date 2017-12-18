//
//  OverlayView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class OverlayView: View {
    
    internal let floatingButton = UIButton(type: .system)
    private var floatingButtonTilteChangeTask: DispatchWorkItem?
    private let defaultFloatingButtonIcon = UIImage(namedInOverlogBundle: "bug")

    override func setupHierarchy() {
        addSubview(floatingButton)
    }

    override func setupProperties() {
        floatingButton.setImage(defaultFloatingButtonIcon, for: .normal)
        floatingButton.layer.cornerRadius = 30.0
        floatingButton.layer.shadowColor = UIColor.black.cgColor
        floatingButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        floatingButton.layer.shadowRadius = 7.0
        floatingButton.layer.shadowOpacity = 0.2
        floatingButton.tintColor = UIColor.OVLWhite
        floatingButton.backgroundColor = UIColor.OVLBlue
        floatingButton.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bringFloatingButtonToFrontIfNeeded()
        floatingButton.frame = framePreventingFloatingButtonToMoveOutOfScreen()
    }

    /// Animates floating button's title.
    ///
    /// - Parameters:
    ///   - fromTitle: Title of the button which appear on the animation's beginning.
    ///   - numberOfSeconds: duration of animation in seconds.
    internal func animateTitleChange(from fromTitle: String, duration numberOfSeconds: Int) {
        if let task = self.floatingButtonTilteChangeTask {
            task.cancel()
        }
        floatingButtonTilteChangeTask = nil
        floatingButton.setImage(nil, for: .normal)
        floatingButton.setTitle(fromTitle, for: .normal)

        let task = DispatchWorkItem { [weak self] in
            self?.floatingButton.setImage(self?.defaultFloatingButtonIcon, for: .normal)
            self?.floatingButton.setTitle(nil, for: .normal)
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

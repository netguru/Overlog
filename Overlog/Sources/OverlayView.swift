//
//  OverlayView.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class OverlayView: View {
    
    internal let floatingButton = UIButton(type: .system)
    private var floatingButtonTitleChangeTask: DispatchWorkItem?
    private let defaultFloatingButtonIcon = UIImage(namedInOverlogBundle: "overlog-bug")

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
        floatingButton.imageEdgeInsets = .init(top: 15, left: 15, bottom: 15, right: 15)
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
    internal func animateTitleChange(to toTitle: String, duration numberOfSeconds: Int) {
        if let task = self.floatingButtonTitleChangeTask {
            task.cancel()
        }
        floatingButtonTitleChangeTask = nil
        animateFloatingButtonImage(toVisible: false)
        floatingButton.setTitle(toTitle, for: .normal)

        let task = DispatchWorkItem { [weak self] in
            self?.animateFloatingButtonImage(toVisible: true)
            self?.floatingButton.setTitle(" ", for: .normal)
            self?.floatingButtonTitleChangeTask = nil
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(numberOfSeconds), execute: task)
        self.floatingButtonTitleChangeTask = task
    }
    
    /// Animates button image change.
    /// By default UIButton only animates when changing titles, not images
    ///
    /// - Parameters:
    ///    - visible: indicates if image of the button should be visible
    private func animateFloatingButtonImage(toVisible visible: Bool) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.floatingButton.imageView?.alpha = visible ? 1 : 0
        }, completion: { [weak self] _ in
            self?.floatingButton.setImage(visible ? self?.defaultFloatingButtonIcon : nil, for: .normal)
        })
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
            bringSubviewToFront(floatingButton)
        }
    }
}

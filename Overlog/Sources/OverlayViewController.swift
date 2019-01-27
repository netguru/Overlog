//
//  OverlayViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal protocol OverlayViewControllerFlowDelegate: class {
    
    /// Tells the flow delegate that floating button has been tapped.
    ///
    /// - Parameters:
    ///   - sender: a button responsible for sending the action
    func didTapFloatingButton(with sender: UIButton)
    
    /// Tells the flow delegate that floating button was dragged to new position
    ///
    /// - Parameter deltaMove: movement delta of floating button
    func didEndDraggingFloatingButton(deltaMove: CGPoint)
}

internal final class OverlayViewController: UIViewController {
    
    /// A delegate responsible for sending flow controller callbacks
    internal weak var flowDelegate: OverlayViewControllerFlowDelegate?
    
    /// Handler of `.motionShake` motion event
    internal var didPerformShakeEvent: ((UIEvent?) -> Void)? = nil
    
    /// Indicates if overlay should autorotate (prevents from rotating notification bar when Overlog is visible)
    internal var shouldAllowAutorotation: Bool = true

    /// The initial center value of `OverlayView.floatingButton` during a drag gesture
    fileprivate var initialFloatingButtonCenter: CGPoint = .zero

    /// The initial delta between `OverlayView.floatingButton` center and its touch point during a drag gesture
    fileprivate var initialFloatingButtonCenterToTouchPointDelta: CGPoint = .zero
    
    /// Overlay view
    internal let overlayView = OverlayView()
    
    internal override func loadView() {
        view = overlayView
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        overlayView.floatingButton.addTarget(
            self,
            action: #selector(didTapFloatingButton(button:)),
            for: .touchUpInside
        )

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didDragFloatingButton(with:)))
        panGesture.maximumNumberOfTouches = 1
        overlayView.floatingButton.addGestureRecognizer(panGesture)
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var shouldAutorotate: Bool {
        return shouldAllowAutorotation
    }
    
    /// Overrides super method and calls `didPerformShakeEvent` closure when `.motionShake` was recevied. 
    /// Please refer to super method documentation for further information.
    ///
    /// - Parameters:
    ///   - motion: `UIEventSubtype`
    ///   - event: `UIEvent`
    internal override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            didPerformShakeEvent?(event)
        }
    }
}

// MARK: - Target actions

fileprivate extension OverlayViewController {

    /// Handle action on touch up inside on `floatingButton`
    ///
    /// - Parameter button: floating button instance
    @objc fileprivate func didTapFloatingButton(button: UIButton) {
        flowDelegate?.didTapFloatingButton(with: button)
    }

    /// Handle the pan gesture on `floatingButton`
    ///
    /// - Parameter recognizer: pan gesture recognizer instance
    @objc fileprivate func didDragFloatingButton(with recognizer: UIPanGestureRecognizer) {
		switch recognizer.state {
		case .began:
			/// Calculate the initial button center value during the gesture
			initialFloatingButtonCenter = overlayView.floatingButton.center

			/// Calculate delta between the touch point and floating button center to eliminate button jumping and provide smoother experience
			let floatingButtonCenter = CGPoint(x: overlayView.floatingButton.frame.width / 2, y: overlayView.floatingButton.frame.height / 2)
			let touchPoint = recognizer.location(in: overlayView.floatingButton)
			initialFloatingButtonCenterToTouchPointDelta = CGPoint(x: floatingButtonCenter.x - touchPoint.x, y: floatingButtonCenter.y - touchPoint.y)
		case .ended, .changed:
			/// Update the `overlayView.floatingButton` center value with current finger position, include the delta
			let overlayTouchPoint = recognizer.location(in: view.superview)
			overlayView.floatingButton.center = CGPoint(x: overlayTouchPoint.x + initialFloatingButtonCenterToTouchPointDelta.x, y: overlayTouchPoint.y + initialFloatingButtonCenterToTouchPointDelta.y)
			
			// When movement ended call delegate with movement delta, also reset origin to zero because delegate should change its window frame
			if case .ended = recognizer.state {
				let deltaMove = CGPoint(x: overlayView.floatingButton.center.x - initialFloatingButtonCenter.x, y: overlayView.floatingButton.center.y - initialFloatingButtonCenter.y)
				flowDelegate?.didEndDraggingFloatingButton(deltaMove: deltaMove)
				overlayView.floatingButton.frame.origin = .zero
			}
		case .cancelled, .failed:
			/// Bring back the initial button center if the gesture gets interrupted
			overlayView.floatingButton.center = initialFloatingButtonCenter
		default:
			break
		}
    }
}

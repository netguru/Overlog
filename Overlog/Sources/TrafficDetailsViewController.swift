//
//  TrafficDetailsViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit
import ResponseDetective

internal protocol TrafficDetailsViewControllerFlowDelegate: class {

    /// Tells the flow delegate that share button has been tapped for activity items.
    ///
    /// - Parameter activityItems: Selected activity items. 
    func didTapShareButton(withItems activityItems: [Any])
}

internal final class TrafficDetailsViewController: UIViewController {

    /// Traffic details View
    fileprivate let customView = TrafficDetailsView()

    /// Network traffic entry instance.
    internal let networkTrafficEntry: NetworkTrafficEntry

    /// Reques view Controller
    fileprivate let requestViewController: RequestViewController

    /// Response view controller
    fileprivate let responseViewController: ResponseViewController

    /// Current displayed view controller
    fileprivate var displayedViewController: UIViewController

    /// A delegate responsible for sending flow controller callbacks
    internal weak var flowDelegate: TrafficDetailsViewControllerFlowDelegate?

    /// Initialise the instance
    ///
    /// - Parameter NetworkTrafficEntry: NetworkTrafficEntry instance
    init(networkTrafficEntry: NetworkTrafficEntry) {
        self.networkTrafficEntry = networkTrafficEntry
        requestViewController = RequestViewController()
        responseViewController = ResponseViewController()
        displayedViewController = requestViewController
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Use init(networkTraffic:) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let shareButton = UIBarButtonItem(image: UIImage(namedInOverlogBundle: "button-share"), style: .plain, target: self, action: #selector(shareButtonPressed))
        navigationItem.rightBarButtonItem = shareButton
        navigationItem.titleView = customView.segmentedControl
        customView.segmentedControl.addTarget(self, action: #selector(didChageSegment(sender:)), for: .valueChanged)
        renderContent()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        display(viewController: displayedViewController)
    }

    override func loadView() {
        super.loadView()
        view.addSubview(customView)
        customView.pinToSuperviewEdges()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customView.segmentedControl.frame.size = .init(width: 240, height: 30)
    }

    internal func renderContent() {
        requestViewController.displayRequest(from: networkTrafficEntry)
        responseViewController.displayResponse(from: networkTrafficEntry)
        customView.segmentedControl.setEnabled(!networkTrafficEntry.isInProgress, forSegmentAt: 1)
    }
}

fileprivate extension TrafficDetailsViewController {

    @objc func didChageSegment(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                display(viewController: requestViewController)
            case 1:
                display(viewController: responseViewController)
            default:
                break
        }
    }

    @objc fileprivate func shareButtonPressed() {
        switch customView.segmentedControl.selectedSegmentIndex {
        case 0:
            if let content = try? self.networkTrafficEntry.request.deserialize(with: .json) {
                self.flowDelegate?.didTapShareButton(withItems: ["{\n\"Request\": " + content + "\n}"])
            }
        case 1:
            if
                let response = self.networkTrafficEntry.response,
                let content = try? response.deserialize(with: .json) {
                self.flowDelegate?.didTapShareButton(withItems: ["{\n\"Response\": " + content + "\n}"])
            }
        default:
            break
        }
    }

    /// Display proper view controller like in container view controller
    ///
    /// - Parameter viewController: View Controller to be displayed
    func display(viewController: UIViewController) {
        displayedViewController.view.removeFromSuperview()
        displayedViewController.removeFromParent()

        viewController.view.frame = customView.contentView.bounds
        customView.contentView.addSubview(viewController.view)

        viewController.willMove(toParent: self)
        addChild(viewController)

        viewController.didMove(toParent: self)
        displayedViewController = viewController
    }

}

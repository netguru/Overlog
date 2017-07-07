//
//  TrafficDetailsViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class TrafficDetailsViewController: UIViewController {

    /// Traffic details View
    fileprivate let customView = TrafficDetailsView()

    /// Reques view Controller
    fileprivate let requestViewController: RequestViewController

    /// Response view controller
    fileprivate let responseViewController: ResponseViewController

    /// Current displayed view controller
    fileprivate var displayedViewController: UIViewController

    /// Initialise the instance
    ///
    /// - Parameter networkTraffic: networkTraffic instance
    init(networkTraffic: NetworkTraffic) {
        requestViewController = RequestViewController(networkRequest: networkTraffic.request)
        responseViewController = ResponseViewController(networkTraffic: networkTraffic)
        displayedViewController = requestViewController
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.segmentedControl.addTarget(self, action: #selector(didChageSegment(sender:)), for: .valueChanged)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        display(viewController: requestViewController)
    }

    override func loadView() {
        super.loadView()

        view = customView
    }

    @available(*, unavailable, message: "Use init(networkTraffic:) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    /// Display proper view controller like in container view controller
    ///
    /// - Parameter viewController: View Controller to be displayed
    func display(viewController: UIViewController) {
        displayedViewController.view.removeFromSuperview()
        displayedViewController.removeFromParentViewController()

        viewController.view.frame = customView.contentView.bounds
        customView.contentView.addSubview(viewController.view)

        viewController.willMove(toParentViewController: self)
        addChildViewController(viewController)

        viewController.didMove(toParentViewController: self)
        displayedViewController = viewController
    }

}

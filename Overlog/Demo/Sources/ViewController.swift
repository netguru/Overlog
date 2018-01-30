//
//  ViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit
import Overlog

/// A dummy view controller.
internal final class ViewController: UITableViewController {

    /// - SeeAlso: UIViewController.viewDidLoad()
    internal override func viewDidLoad() {

        super.viewDidLoad()

        navigationItem.title = "Overlog Demo"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil)

        let configuration = URLSessionConfiguration.default
        Overlog.shared.enableHTTPTrafficDebugging(in: configuration)

        let session = URLSession(configuration: configuration)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            session.dataTask(with: .get(url: "https://httpbin.org/get")).resume()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            session.dataTask(with: .post(url: "https://httpbin.org/post", body: "hello, world!")).resume()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            session.dataTask(with: .get(url: "https://httpusrlocalbin.org/get")).resume()
        }

    }
}

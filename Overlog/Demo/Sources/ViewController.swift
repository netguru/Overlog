//
//  ViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit
import Overlog

final class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Title"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(leftButtonTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(rightButtonTap))

        let configuration = URLSessionConfiguration.default

        Overlog.shared.enableNetworkDebugging(inConfiguration: configuration)
        let session = URLSession(configuration: configuration)
        let request = URLRequest(url: URL(string: "https://cljsbin-bkhgroqzwe.now.sh/headers")!)
        session.dataTask(with: request).resume()


        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            let delayedRequest = URLRequest(url: URL(string: "https://cljsbin-bkhgroqzwe.now.sh/get")!)
            session.dataTask(with: delayedRequest).resume()
        }
    }
    
    @objc private func leftButtonTap() {
        let newVC = ViewController()
        let navWC = UINavigationController(rootViewController: newVC)
        UIApplication.shared.delegate!.window!!.rootViewController = navWC
    }
    
    @objc private func rightButtonTap() {
        let newVC = ViewController()
        let navWC = UINavigationController(rootViewController: newVC)
        present(navWC, animated: true)
    }
}

//
// ViewController.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit
import ResponseDetective

final class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Title"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)

        let configuration = URLSessionConfiguration.default
        ResponseDetective.enable(inConfiguration: configuration)
        let session = URLSession(configuration: configuration)
        let request = URLRequest(url: URL(string: "https://cljsbin-bkhgroqzwe.now.sh/headers")!)
        session.dataTask(with: request).resume()

    }
 
}

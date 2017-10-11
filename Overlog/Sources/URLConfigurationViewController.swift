//
//  URLConfigurationViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class URLConfigurationViewController: UIViewController {

    fileprivate let customView = URLConfigurationView()
    fileprivate var scheme: Scheme
    fileprivate var host: String?
    
    init() {
        scheme = URLConfigurationStorage.scheme
        host = URLConfigurationStorage.host
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "Use init() instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func loadView() {
        view = customView
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        let http = Scheme.http.rawValue
        let https = Scheme.https.rawValue
        
        customView.segmentedControl.addTarget(self, action: #selector(segmentedControlDidChangeValue(sender:)), for: .valueChanged)
        customView.segmentedControl.insertSegment(withTitle: http, at: 0, animated: false)
        customView.segmentedControl.insertSegment(withTitle: https, at: 1, animated: false)
        customView.segmentedControl.selectedSegmentIndex = {
            switch URLConfigurationStorage.scheme {
            case .http: return 0
            case .https: return 1
            }
        }()
        customView.inputField.addTarget(self, action: #selector(inputFieldDidChangeValue(sender:)), for: .editingChanged)
        customView.inputField.text = host
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save".localized, style: .plain, target: self, action: #selector(saveBarButtonDidTap(sender:)))
    }
    
    internal override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        customView.inputField.becomeFirstResponder()
    }
}

private extension URLConfigurationViewController {
    
    @objc func segmentedControlDidChangeValue(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: scheme = .http
        case 1: scheme = .https
        default: break
        }
    }
    
    @objc func inputFieldDidChangeValue(sender: UITextField) {
        host = sender.text
    }
    
    @objc func saveBarButtonDidTap(sender: UITextField) {
        URLConfigurationStorage.scheme = scheme
        URLConfigurationStorage.host = host
        NotificationCenter.default.post(name: Overlog.URLConfigurationDidChangeNotificationKey, object: nil)
        navigationController?.popViewController(animated: true)
    }
}


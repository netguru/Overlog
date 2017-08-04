//
//  JiraSessionProvider.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

internal final class JiraSessionProvider {
    
    private let jiraTokenKey = "OVLJiraAuthenticationKey"
    private let endpointURL = ""
    
    var isAuthenticated: Bool {
        if let result = try? Keychain().contains(jiraTokenKey) {
            return result
        } else {
            return false
        }
    }
    
    func authenticate(with login: String, password: String, completionHandler: @escaping (NetworkResponse) -> ()) {
        guard isAuthenticated == false else {
            completionHandler(NetworkResponse.error(error: JiraError.authenticated))
            return
        }
    }
    
    func logout() {
        try? Keychain().remove(jiraTokenKey)
    }
}

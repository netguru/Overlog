//
//  JiraError.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

internal enum JiraError: Error {
    case authenticated
    
    var localizedDescription: String {
        switch self {
        case .authenticated:
            return "User already authenticated".localized
        }
    }
}

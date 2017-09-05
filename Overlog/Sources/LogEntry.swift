//
//  LogEntry.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import Foundation
import asl

/// Default ASL log keys
private enum Keys: String {
    case time, sender, message

    var rawValue: String {
        switch self {
        case .time: return ASL_KEY_TIME;
        case .sender: return ASL_KEY_SENDER;
        case .message: return ASL_KEY_MSG;
        }
    }
}

/// Overlog log model
public struct LogEntry {

    let date: Date?
    let sender: String
    let message: String

    /// Log initializer
    ///
    /// - Parameters:
    ///   - raw: raw log dictionary returned by ASL
    init(raw log: [String: String]) {
        if let time = log[Keys.time.rawValue], let timeInterval = TimeInterval(time) {
            date = Date(timeIntervalSince1970:timeInterval)
        } else {
            date = nil
        }
        sender = log[Keys.sender.rawValue] ?? ""
        message = log[Keys.message.rawValue] ?? ""
    }

    /// Log initializer
    ///
    /// - Parameters:
    ///   - timestamp: date of the logged event
    ///   - sender: the object which sent the log
    ///   - message: the body of the log
    init(date: Date?, sender: String?, message: String?) {
        self.date = date
        self.sender = sender ?? ""
        self.message = message ?? ""
    }

}

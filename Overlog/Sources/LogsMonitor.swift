//
//  LogsMonitor.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Foundation

internal protocol LogsMonitor {

    var delegate: LogsMonitorDelegate? { get set }
    
    // MARK: Abstract

    /// Start monitoring for new data
    func subscribeForLogs()
}

/// A LogsMonitorDelegate delegate protocol for notifying about new logs available.
internal protocol LogsMonitorDelegate: class {

    /// Triggered when Monitor gets system logs
    ///
    /// - parameter monitor: An object that get notice about a log
    /// - parameter logs: all system logs gathered
    func monitor(_ monitor: LogsMonitor, didGet logs: [LogEntry])
}


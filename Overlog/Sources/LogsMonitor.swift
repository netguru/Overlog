//
//  LogsMonitor.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

public class LogsMonitor {

    weak public var delegate: LogsMonitorDelegate?

    public func subscribeForLogs() {
        fatalError("subscribeForLogs() has not been implemented - you should always use a subclass!")
    }
}

/// A LogsMonitorDelegate delegate protocol for notifying about new logs available.
public protocol LogsMonitorDelegate: class {

    /// Triggered when Monitor gets system logs
    ///
    /// - parameter monitor: An object that get notice about a log
    /// - parameter logs: all system logs gathered
    func monitor(_ monitor: LogsMonitor, didGet logs: [Log])
}


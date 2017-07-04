//
//  LogsMonitor.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

/// A class to monitor the logs printed in the console
final public class LogsMonitor {

    /// An deleaget for a notifications
    weak public var delegate: LogsMonitorDelegate?

    public init() {
        
    }
}

/// A LogsMonitorDelegate delegate protocol for notification whenever any log appears in console
public protocol LogsMonitorDelegate: class {

    /// Triggerd when LogsMonitor gets a new log
    ///
    /// - parameter monitor: An object that get notice about a log
    /// - parameter log: recived log
    func monitor(_ monitor: LogsMonitor, didGet log: String)

}

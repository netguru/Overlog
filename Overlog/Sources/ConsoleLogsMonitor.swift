//
//  ConsoleLogsMonitor.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

/// A class to monitor the logs printed in the console
final public class ConsoleLogsMonitor: LogsMonitor {

    /// A buffer of logs
    public fileprivate(set) var logs: [LogEntry] = []

    /// Start monitoring for new data in standard and error outputs.
    ///
    /// - Remark:
    /// Subscribes for gathering logs only in a release mode. In the debug mode
    /// logs will be visible in a console window. It is a workaround for a fact
    /// that stdout and stderr outputs can be redirected only to a one handle.
    public override func subscribeForLogs() {
        #if ENV_DEBUG
            return
        #else
            let pipe = Pipe()
            let handle = pipe.fileHandleForReading
            dup2(pipe.fileHandleForWriting.fileDescriptor, fileno(stderr))
            dup2(pipe.fileHandleForWriting.fileDescriptor, fileno(stdout))

            NotificationCenter.default.addObserver(self, selector: #selector(dataAvailable(notification:)), name: NSNotification.Name.NSFileHandleDataAvailable, object: nil)
            handle.waitForDataInBackgroundAndNotify()
        #endif
    }

    /// Parse available output data
    @objc private func dataAvailable(notification: Notification) {
        if let fileHandle = notification.object as? FileHandle {

            if let parsedData = NSString(data: fileHandle.availableData, encoding: String.Encoding.utf8.rawValue) {
                let newLog = LogEntry(timestamp: Date(), sender: nil, message: parsedData as String)
                logs.append(newLog)
                DispatchQueue.main.async {
                    self.delegate?.monitor(self, didGet: self.logs)
                }
            }

            fileHandle.waitForDataInBackgroundAndNotify()
        }
    }
}

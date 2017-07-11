//
//  SystemLogsMonitor.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

/// ASL module is deprecated and replaced by os_log(3). However, the new implementation
/// lacks a possibility to search for logs in the current run environment (it has yet
/// to be implemented / released to the public by Apple). The decission was made to
/// use the ASL as is it still being supported.
import asl

/// A class to monitor the system logs
final public class SystemLogsMonitor: LogsMonitor {

    /// The ASL client associated with the receiver
    fileprivate(set) var aslClient: aslclient
    fileprivate(set) var fileURL: String?

    public override init() {
        self.aslClient = asl_open(ProcessInfo.processInfo.processName, nil, 0x00000001)
    }

    /// Perform a one-time scan for all logs generated by the host app
    public override func subscribeForLogs() {

        /// Searching for all logs
        let query = asl_new(UInt32(ASL_TYPE_QUERY))
        let results = asl_search(aslClient, query)

        var logsArray = [LogEntry]()
        var record = asl_next(results)

        /// Iterating for logs read by asl_search command
        while record != nil {

            var logDictionary = [String: String]()

            var i = UInt32(0)
            var key = asl_key(record, i)
            while key != nil {
                let keyStr = String(cString: key!)
                if let val = asl_get(record, keyStr) {
                    let valString = String(cString: val)
                    logDictionary[keyStr] = valString
                }
                i += 1
                key = asl_key(record, i)
            }

            let log = LogEntry(raw: logDictionary)
            logsArray.append(log)

            record = asl_next(results)
        }

        asl_release(results)
        delegate?.monitor(self, didGet: logsArray)
    }

    deinit {
        asl_close(aslClient)
    }

}

//
//  SystemLogsMonitorSpec.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import Quick
import Nimble
import Overlog

class SystemLogsMonitorSpec: QuickSpec {

    override func spec() {
        var monitor: SystemLogsMonitor!

        describe("when requesting system logs") {

            beforeEach {
                monitor = SystemLogsMonitor()
            }

            afterEach {
                monitor = nil
            }

            context("will notify about") {

                var delegate: SystemLogsMonitorDelegateMock!

                beforeEach {
                    delegate = SystemLogsMonitorDelegateMock()
                    monitor.delegate = delegate
                    monitor.subscribeForLogs()
                }

                afterEach {
                    delegate = nil
                }

                it("availability of system logs") {
                    expect(monitor).toNot(beNil())
                    expect((monitor.delegate as! SystemLogsMonitorDelegateMock).logsCounter).toEventually(beGreaterThan(0))
                }
            }
        }
    }
}

final class SystemLogsMonitorDelegateMock: LogsMonitorDelegate {

    var logsCounter = 0

    func monitor(_ monitor: LogsMonitor, didGet logs: [Log]) {
        logsCounter = logs.count
    }
}

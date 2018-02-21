//
//  ConfigurationSpec.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import Quick
import Nimble
@testable import Overlog

class ConfigurationSpec: QuickSpec {

    override func spec() {
        
        describe("Overlog.Configuration") {

            var sut: Overlog.Configuration!

            beforeEach {
                sut = Overlog.Configuration()
            }

            afterEach {
                sut = nil
            }

            it("should post notification when changing enabled features") {
                expect { sut.enabledFeatures = [] }.to(postNotifications(contain(Notification(name: .overlogEnabledFeaturesDidChange))))
            }

        }
    }
}

//
// DummySpec.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import UIKit

internal final class DummySpec: QuickSpec { override func spec() {

	it("roses are red") {

		struct Rose {
			static let color: UIColor = .red
		}

		expect(Rose.color).to(equal(UIColor.red))

	}


}}

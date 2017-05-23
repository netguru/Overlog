//
// FooSpec.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Quick
import Nimble
import Overlog
import Result
import SwiftCheck

internal final class FooSpec: QuickSpec { override func spec() {

	sc_it("Foo.divide(_:over:) divides by a non-zero number correctly") {
		forAll { (divident: Double, divisor: Double) in
			divisor != 0 ==> expect { try Foo.divide(divident, over: divisor).dematerialize() }.sc_to(equal(divident / divisor))
		}
	}

	it("Foo.divide(_:over:) throws an error when dividing by zero") {
		expect { try Foo.divide(1, over: 0).dematerialize() }.to(throwError(Foo.Error.divisionByZero))
	}

}}

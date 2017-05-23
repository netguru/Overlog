//
// Foo.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Result

/// A `Foo`.
public struct Foo {

	/// Errors thrown in `Foo`.
	public enum Error: Swift.Error {

		/// Error thrown when dividing by zero.
		case divisionByZero

	}

	/// Divide `divident` by `divisor`.
	///
	/// - Parameters:
	///     - divident: A divident.
	///     - divisor: A divisor.
	///
	/// - Throws: `Foo.Error.divisionByZero` if `divisor` is zero.
	///
	/// - Returns: A result of division.
	public static func divide(_ divident: Double, over divisor: Double) -> Result<Double, Error> {
		guard divisor != 0 else { return .failure(.divisionByZero) }
		return .success(divident / divisor)
	}

}

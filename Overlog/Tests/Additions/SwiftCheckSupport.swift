//
// SwiftCheckSupport.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//
// This source file contains integration support between `SwiftCheck`, `Quick`
// and `Nimble`. The result of that integration is the ability to use `to` and
// `toNot` matchers inside `property` assertions that are integrated with `it`
// test cases:
//
//     sc_it("unsigned integers should be greater or equal zero") {
//         forAll { (x: UInt) in
//             expect(x).sc_toNot(beLessThan(0))
//         }
//     }
//
// Default `it`, `to`, `toNot` and `property` functions remain unaffected and
// not overloaded.
//

import Nimble
import Quick
import SwiftCheck

internal extension Expectation {

	/// Evaluate the expectation with a predicate and return a `Testable` result
	/// instead of asserting it in a handler.
	///
	/// - Parameters:
	///     - predicate: The predicate to use.
	///     - description: An custom expectation description.
	///
	/// - Returns: A `Testable` result that can be returned as a result of a
	///   quantifier.
	internal func sc_to(_ predicate: Predicate<T>, description: String? = nil) -> Testable {
		return makeTestable(predicate: predicate, userDescription: description, intention: .toMatch)
	}

	/// Evaluate the expectation with a predicate and return a `Testable` result
	/// instead of asserting it in a handler.
	///
	/// - Parameters:
	///     - predicate: The predicate to use.
	///     - description: An custom expectation description.
	///
	/// - Returns: A `Testable` result that can be returned as a result of a
	///   quantifier.
	internal func sc_toNot(_ predicate: Predicate<T>, description: String? = nil) -> Testable {
		return makeTestable(predicate: predicate, userDescription: description, intention: .toNotMatch)
	}

	/// Evaluate the expectation with a predicate and return a `Testable` result
	/// instead of asserting it in a handler.
	///
	/// - Parameters:
	///     - predicate: A predicate to use.
	///     - userDescription: A custom expectation description.
	///     - intention: An intention of expectation.
	///
	/// - Returns: A `Testable` result that can be returned as a result of a
	///   quantifier.
	private func makeTestable(predicate: Predicate<T>, userDescription: String?, intention: ExpectationIntention) -> Testable {
		return predicate.makeTestResult(expression: expression, intention: intention, failureMessage: FailureMessage(userDescription: userDescription, toDescription: intention.toDescription))
	}

}

// MARK: -

/// Create a `Property` wrapped in a `Quick` test case. This makes `property`
/// tests conform to `Quick` world, and makes them compatible with spec structure
/// (e.g. makes them respect `beforeEach`, etc.).
///
/// - Parameters:
///     - description: Description of the test case.
///     - arguments: The checker arguments for replaying tests.
///     - flags: Flags to filter examples or example groups.
///     - file: Source file where the call was made.
///     - line: Line at which the call was made.
///     - closure: A closure acting as a test body.
internal func sc_it(_ description: String, arguments: CheckerArguments? = nil, flags: FilterFlags = [:], file: StaticString = #file, line: UInt = #line, _ closure: @escaping () -> Property) {
	it(description, flags: flags, file: String(describing: file), line: line) {
		property(description, arguments: arguments, file: file, line: line) <- closure()
	}
}

// MARK: -

/// Describes an intention of an expectation.
fileprivate enum ExpectationIntention {

	/// The intention is to match.
	case toMatch

	/// The intention is to not match.
	case toNotMatch

	// MARK: Properties

	/// A "to" or "to not" description of this intention.
	fileprivate var toDescription: String {
		switch self {
			case .toMatch: return "to"
			case .toNotMatch: return "to not"
		}
	}
	
}

// MARK: -

fileprivate extension Predicate {

	/// Evaluate the predicate against an expression and return a `Testable`
	/// result.
	///
	/// - Parameters:
	///     - expression: An expression to evaluate against.
	///     - intention: An expectation intention.
	///     - failureMessage: An instance of `FailureMessage`.
	///
	/// - Returns: A `TestResult` instance that can be returned as a result of a
	///   quantifier.
	fileprivate func makeTestResult(expression: Expression<T>, intention: ExpectationIntention, failureMessage: FailureMessage) -> TestResult {
		return NMBExceptionCapture.coalescing(
			try: {
				do {
					failureMessage.actualValue = "<\(stringify(try expression.evaluate()))>"
					if try evaluate(against: expression, intention: intention, failureMessage: failureMessage) {
						return .succeeded
					} else {
						return .failed(failureMessage.stringValue)
					}
				} catch let error {
					failureMessage.stringValue = "unexpected error thrown: <\(error)>"
					return .failed(failureMessage.stringValue)
				}
			},
			catch: { exception in
				failureMessage.stringValue = "unexpected exception raised: \(exception)"
				return .failed(failureMessage.stringValue)
			}
		)
	}

	/// Evaluate the predicate against an `expression` and return a `Bool`
	/// indicating whether the evaluation was successful.
	///
	/// - Parameters:
	///     - expression: An expression to evaluate against.
	///     - intention: An expectation intention.
	///     - failureMessage: An instance of `FailureMessage`.
	///
	/// - Returns: A `Bool` value indicating success of evaluation.
	private func evaluate(against expression: Expression<T>, intention: ExpectationIntention, failureMessage: FailureMessage) throws -> Bool {
		switch intention {
			case .toMatch: return try matches(expression, failureMessage: failureMessage)
			case .toNotMatch: return try doesNotMatch(expression, failureMessage: failureMessage)
		}
	}

}

// MARK: -

fileprivate extension NMBExceptionCapture {

	/// Try to execute `try` closure and if it throws an Objective-C exception,
	/// coalesce the result by `catch` closure.
	///
	/// - Parameters:
	///     - try: A `@try` closure.
	///     - catch: A `@catch` closure.
	///
	/// - Returns: A result.
	fileprivate static func coalescing<Result>(try: () -> Result, catch: @escaping (NSException) -> Result) -> Result {
		var result: Result!
		NMBExceptionCapture(handler: { result = `catch`($0) }).tryBlock { result = `try`() }
		return result
	}

}

// MARK: -

fileprivate extension FailureMessage {

	/// Initialize a `FailureMessage` with `userDescription`, `to` and
	/// `actualValue`.
	///
	/// - Parameters:
	///     - userDescription: A user-provided description of an expectation.
	///     - toDescription: Words to use as "to" or "to not".
	///     - actualValueDescription: Description of an actual value.
	fileprivate convenience init(userDescription: String?, toDescription: String) {
		self.init()
		self.userDescription = userDescription
		self.to = toDescription
	}

}

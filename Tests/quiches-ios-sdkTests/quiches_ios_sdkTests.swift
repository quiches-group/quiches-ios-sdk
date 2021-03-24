import XCTest
@testable import quiches_ios_sdk

final class quiches_ios_sdkTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(quiches_ios_sdk().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(quiches_ios_sdkTests.allTests),
    ]
}
#endif

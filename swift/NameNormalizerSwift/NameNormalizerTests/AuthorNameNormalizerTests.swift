@testable import NameNormalizer
import XCTest

class AuthorNameNormalizerTests: XCTestCase {

    func testReturnsEmptyStringWhenEmpty() throws {
        try XCTSkipIf(true, "disabled")
        XCTAssertEqual(try normalize(name: ""), "")
    }

    func testReturnsSingleWordName() throws {
        try XCTSkipIf(true, "disabled")
        XCTAssertEqual(try normalize(name: "Plato"), "Plato")
    }

    func testSwapsFirstAndLastNames() throws {
        try XCTSkipIf(true, "disabled")
        XCTAssertEqual(try normalize(name: "Haruki Murakami"), "Murakami, Haruki")
    }

    func testTrimsLeadingAndTrailingWhitespace() throws {
        try XCTSkipIf(true, "disabled")
        XCTAssertEqual(try normalize(name: "  Big Boi   "), "Boi, Big")
    }

    func testInitializesMiddleName() throws {
        try XCTSkipIf(true, "disabled")
        XCTAssertEqual(try normalize(name: "Henry David Thoreau"), "Thoreau, Henry D.")
    }

    func testDoesNotInitializeOneLetterMiddleName() throws {
        try XCTSkipIf(true, "disabled")
        XCTAssertEqual(try normalize(name: "Harry S Truman"), "Truman, Harry S")
    }

    func testInitializesEachOfMultipleMiddleNames() throws {
        try XCTSkipIf(true, "disabled")
        XCTAssertEqual(try normalize(name: "Julia Scarlett Elizabeth Louis-Dreyfus"), "Louis-Dreyfus, Julia S. E.")
    }

    func testAppendsSuffixesToEnd() throws {
        try XCTSkipIf(true, "disabled")
        XCTAssertEqual(try normalize(name: "Martin Luther King, Jr."), "King, Martin L., Jr.")
    }

    func testThrowsWhenNameContainsTwoCommas() throws {
        try XCTSkipIf(true, "disabled")
        XCTAssertThrowsError(try normalize(name: "Thurston, Howell, III"))
    }
}

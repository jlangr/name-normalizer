@testable import NameNormalizer
import XCTest

class AuthorNameNormalizerTests: XCTestCase {

    func testReturnsEmptyStringWhenEmpty() {
        XCTAssertEqual(try normalize(name: ""), "")
    }

    func testReturnsSingleWordName() {
        XCTAssertEqual(try normalize(name: "Plato"), "Plato")
    }

    func testSwapsFirstAndLastNames() {
        XCTAssertEqual(try normalize(name: "Haruki Murakami"), "Murakami, Haruki")
    }

    func testTrimsLeadingAndTrailingWhitespace() {
        XCTAssertEqual(try normalize(name: "  Big Boi   "), "Boi, Big")
    }

    func testInitializesMiddleName() {
        XCTAssertEqual(try normalize(name: "Henry David Thoreau"), "Thoreau, Henry D.")
    }

    func testDoesNotInitializeOneLetterMiddleName() {
        XCTAssertEqual(try normalize(name: "Harry S Truman"), "Truman, Harry S")
    }

    func testInitializesEachOfMultipleMiddleNames() {
        XCTAssertEqual(try normalize(name: "Julia Scarlett Elizabeth Louis-Dreyfus"), "Louis-Dreyfus, Julia S. E.")
    }

    func DISABLED_testAppendsSuffixesToEnd() {
        XCTAssertEqual(try normalize(name: "Martin Luther King, Jr."), "King, Martin L., Jr.")
    }

    func DISABLED_testThrowsWhenNameContainsTwoCommas() {
        XCTAssertThrowsError(try normalize(name: "Thurston, Howell, III"))
    }
}

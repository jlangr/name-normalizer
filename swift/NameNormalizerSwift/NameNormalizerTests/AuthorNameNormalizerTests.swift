@testable import NameNormalizer
import XCTest

class AuthorNameNormalizerTests: XCTestCase {
    var normalizer: AuthorNameNormalizer!

    override func setUp() {
        super.setUp()
        normalizer = AuthorNameNormalizer()
    }

    override func tearDown() {
        normalizer = nil
        super.tearDown()
    }

    func DISABLED_testReturnsEmptyStringWhenEmpty() {
        XCTAssertEqual(try normalizer.normalize(""), "")
    }

    func DISABLED_testReturnsSingleWordName() {
        XCTAssertEqual(try normalizer.normalize("Plato"), "Plato")
    }

    func DISABLED_testSwapsFirstAndLastNames() {
        XCTAssertEqual(try normalizer.normalize("Haruki Murakami"), "Murakami, Haruki")
    }

    func DISABLED_testTrimsLeadingAndTrailingWhitespace() {
        XCTAssertEqual(try normalizer.normalize("  Big Boi   "), "Boi, Big")
    }

    func DISABLED_testInitializesMiddleName() {
        XCTAssertEqual(try normalizer.normalize("Henry David Thoreau"), "Thoreau, Henry D.")
    }

    func DISABLED_testDoesNotInitializeOneLetterMiddleName() {
        XCTAssertEqual(try normalizer.normalize("Harry S Truman"), "Truman, Harry S")
    }

    func DISABLED_testInitializesEachOfMultipleMiddleNames() {
        XCTAssertEqual(try normalizer.normalize("Julia Scarlett Elizabeth Louis-Dreyfus"), "Louis-Dreyfus, Julia S. E.")
    }

    func DISABLED_testAppendsSuffixesToEnd() {
        XCTAssertEqual(try normalizer.normalize("Martin Luther King, Jr."), "King, Martin L., Jr.")
    }

    func DISABLED_testThrowsWhenNameContainsTwoCommas() {
        XCTAssertThrowsError(try normalizer.normalize("Thurston, Howell, III"))
    }
}

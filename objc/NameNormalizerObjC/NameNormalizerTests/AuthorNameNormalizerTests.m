#import "AuthorNameNormalizer.h"
@import XCTest;

@interface AuthorNameNormalizerTests : XCTestCase
@end

@implementation AuthorNameNormalizerTests
{
    AuthorNameNormalizer *normalizer;
}

- (void)setUp
{
    [super setUp];
    normalizer = [[AuthorNameNormalizer alloc] init];
}

- (void)tearDown
{
    normalizer = nil;
    [super tearDown];
}

- (void)testReturnsEmptyStringWhenEmpty
{
    XCTAssertEqualObjects([normalizer normalize:@""], @"");
}

- (void)testReturnsSingleWordName
{
    XCTAssertEqualObjects([normalizer normalize:@"Plato"], @"Plato");
}

- (void)testSwapsFirstAndLastNames
{
    XCTAssertEqualObjects([normalizer normalize:@"Haruki Murakami"], @"Murakami, Haruki");
}

- (void)testTrimsLeadingAndTrailingWhitespace
{
    XCTAssertEqualObjects([normalizer normalize:@"  Big Boi   "], @"Boi, Big");
}

- (void)testInitializesMiddleName
{
    XCTAssertEqualObjects([normalizer normalize:@"Henry David Thoreau"], @"Thoreau, Henry D.");
}

- (void)testDoesNotInitializeOneLetterMiddleName
{
    XCTAssertEqualObjects([normalizer normalize:@"Harry S Truman"], @"Truman, Harry S");
}

- (void)testInitializesEachOfMultipleMiddleNames
{
    XCTAssertEqualObjects([normalizer normalize:@"Julia Scarlett Elizabeth Louis-Dreyfus"], @"Louis-Dreyfus, Julia S. E.");
}

- (void)testAppendsSuffixesToEnd
{
    XCTAssertEqualObjects([normalizer normalize:@"Martin Luther King, Jr."], @"King, Martin L., Jr.");
}

- (void)testThrowsWhenNameContainsTwoCommas
{
    XCTAssertThrows([normalizer normalize:@"Thurston, Howell, III"]);
}

@end

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
    XCTSkip(@"disabled");
    XCTAssertEqualObjects([normalizer normalize:@""], @"");
}

- (void)testReturnsSingleWordName
{
    XCTSkip(@"disabled");
    XCTAssertEqualObjects([normalizer normalize:@"Plato"], @"Plato");
}

- (void)testSwapsFirstAndLastNames
{
    XCTSkip(@"disabled");
    XCTAssertEqualObjects([normalizer normalize:@"Haruki Murakami"], @"Murakami, Haruki");
}

- (void)testTrimsLeadingAndTrailingWhitespace
{
    XCTSkip(@"disabled");
    XCTAssertEqualObjects([normalizer normalize:@"  Big Boi   "], @"Boi, Big");
}

- (void)testInitializesMiddleName
{
    XCTSkip(@"disabled");
    XCTAssertEqualObjects([normalizer normalize:@"Henry David Thoreau"], @"Thoreau, Henry D.");
}

- (void)testDoesNotInitializeOneLetterMiddleName
{
    XCTSkip(@"disabled");
    XCTAssertEqualObjects([normalizer normalize:@"Harry S Truman"], @"Truman, Harry S");
}

- (void)testInitializesEachOfMultipleMiddleNames
{
    XCTSkip(@"disabled");
    XCTAssertEqualObjects([normalizer normalize:@"Julia Scarlett Elizabeth Louis-Dreyfus"], @"Louis-Dreyfus, Julia S. E.");
}

- (void)testAppendsSuffixesToEnd
{
    XCTSkip(@"disabled");
    XCTAssertEqualObjects([normalizer normalize:@"Martin Luther King, Jr."], @"King, Martin L., Jr.");
}

- (void)testThrowsWhenNameContainsTwoCommas
{
    XCTSkip(@"disabled");
    XCTAssertThrows([normalizer normalize:@"Thurston, Howell, III"]);
}

@end

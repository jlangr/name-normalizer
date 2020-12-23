#include "gmock/gmock.h"

#include "NameNormalizer.h"

using namespace testing;
using namespace std;
using namespace name_util;

TEST(ANameNormalizer, ReturnsAnEmptyStringWhenGivenSame) {
    ASSERT_THAT(normalize(""), StrEq(""));
}

TEST(ANameNormalizer, SimplyReturnsASingleWordName) {
    ASSERT_THAT(normalize("Plato"), StrEq("Plato"));
}

TEST(ANameNormalizer, SwapsFirstAndLastNames) {
    ASSERT_THAT(normalize("Haruki Murakami"), StrEq("Murakami, Haruki"));
}

TEST(ANameNormalizer, TrimsWhitespace) {
    ASSERT_THAT(normalize("  Big Boi   "), StrEq("Boi, Big"));
}

TEST(ANameNormalizer, ReplacesMiddleNameWithInitial) {
    ASSERT_THAT(normalize("Henry David Thoreau"), StrEq("Thoreau, Henry D."));
}

TEST(ANameNormalizer, DoesNotInitializeOneLetterMiddleName) {
    ASSERT_THAT(normalize("Harry S Truman"), StrEq("Truman, Harry S"));
}

TEST(ANameNormalizer, InitializesEachOfMultipleMiddleNames) {
    ASSERT_THAT(normalize("Julia Scarlett Elizabeth Louis-Dreyfus"), StrEq("Louis-Dreyfus, Julia S. E."));
}

TEST(ANameNormalizer, AppendsSuffixesToEnd) {
    ASSERT_THAT(normalize("Martin Luther King, Jr."), StrEq("King, Martin L., Jr."));
}

TEST(ANameNormalizer, ThrowsWhenNameContainsTwoCommas) {
    ASSERT_THROW(normalize("Thurston, Howell, III"), InvalidNameException);
}

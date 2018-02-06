#include "gmock/gmock.h"

#include "NameNormalizer.h"

using namespace testing;
using namespace std;
using namespace name_util;

TEST(ANameNormalizer, DISABLED_ReturnsAnEmptyStringWhenGivenSame) {
    ASSERT_THAT(normalize(""), StrEq(""));
}

TEST(ANameNormalizer, DISABLED_SimplyReturnsASingleWordName) {
    ASSERT_THAT(normalize("Plato"), StrEq("Plato"));
}

TEST(ANameNormalizer, DISABLED_SwapsFirstAndLastNames) {
    ASSERT_THAT(normalize("Haruki Murakami"), StrEq("Murakami, Haruki"));
}

TEST(ANameNormalizer, DISABLED_TrimsWhitespace) {
    ASSERT_THAT(normalize("  Big Boi   "), StrEq("Boi, Big"));
}

TEST(ANameNormalizer, DISABLED_ReplacesMiddleNameWithInitial) {
    ASSERT_THAT(normalize("Henry David Thoreau"), StrEq("Thoreau, Henry D."));
}

TEST(ANameNormalizer, DISABLED_DoesNotInitializeOneLetterMiddleName) {
    ASSERT_THAT(normalize("Harry S Truman"), StrEq("Truman, Harry S"));
}

TEST(ANameNormalizer, DISABLED_InitializesEachOfMultipleMiddleNames) {
    ASSERT_THAT(normalize("Julia Scarlett Elizabeth Louis-Dreyfus"), StrEq("Louis-Dreyfus, Julia S. E."));
}

TEST(ANameNormalizer, DISABLED_AppendsSuffixesToEnd) {
    ASSERT_THAT(normalize("Martin Luther King, Jr."), StrEq("King, Martin L., Jr."));
}

TEST(ANameNormalizer, DISABLED_ThrowsWhenNameContainsTwoCommas) {
    ASSERT_THROW(normalize("Thurston, Howell, III"), InvalidNameException);
}

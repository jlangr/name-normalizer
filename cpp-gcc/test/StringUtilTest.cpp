#include "gmock/gmock.h"

#include "StringUtil.h"

#include <vector>

using namespace testing;
using namespace std;
using namespace stringutil;

TEST(StringUtil_Split, ReturnsVectorOfStrings) {
    ASSERT_THAT(split("abc-def", '-'), Eq(vector<string>{ "abc", "def" }));
}

TEST(StringUtil_Split, SupportsAlternateDelimiters) {
    ASSERT_THAT(split("abc def", ' '), Eq(vector<string>{ "abc", "def" }));
}

TEST(StringUtil_Split, SupportsMultipleSplits) {
    ASSERT_THAT(split("abc def ghi", ' '), Eq(vector<string>{ "abc", "def", "ghi" }));
}

TEST(StringUtil_Split, HandlesDelimiterAtEnd) {
    ASSERT_THAT(split("abc:def:", ':'), Eq(vector<string>{ "abc", "def", "" }));
}

TEST(StringUtil_Split, ReturnsUnchangedStringWhenNoDelimiterExists) {
    ASSERT_THAT(split("abcdef", ':'), Eq(vector<string>{ "abcdef" }));
}

TEST(StringUtil_Split, ReturnsEmptyStringWhenInputEmpty) {
    ASSERT_THAT(split("", ':'), Eq(vector<string>{ "" }));
}

TEST(StringUtil_Trim, EliminatesFrontWhitespace) {
    ASSERT_THAT(stringutil::trim(" \t\n\r abc"), StrEq("abc"));
}

TEST(StringUtil_Trim, EliminatesTrailingWhitespace) {
    ASSERT_THAT(trim("abc \n\t\r "), StrEq("abc"));
}

TEST(StringUtil_Trim, EliminatesWhitespaceFromBothEnds) {
    ASSERT_THAT(trim("   abc  def  "), StrEq("abc  def"));
}

TEST(StringUtil_Trim, LeavesAlreadyTrimmedStringsUntouched) {
    ASSERT_THAT(trim(""), StrEq(""));
}

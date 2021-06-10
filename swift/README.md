The Swift version of name-normalizer is an Xcode project. It uses XCTest, running on macOS,
and requires Xcode 11.4 or higher.

The instructions state that if the test you just enabled does not fail, then you built too much code in a prior step and should revert. There is one possible exception for Swift. Your approach to swapping first and last names may already trim leading and trailing whitespace, depending on which Swift function you use.

One possible solution can be found in the `all-solutions` branch.

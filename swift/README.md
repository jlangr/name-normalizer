The Swift version of name-normalizer is an Xcode project. It uses Swift 4 and XCTest, running on macOS.

The instructions state that if the test you just enabled does not fail, then you built too much code in a prior step and should revert. There is one possible exception for Swift. Your approach to swapping first and last names may already trim leading and trailing whitespace, depending on which Swift function you use.

One possible solution can be found in the `swift-solution` branch, as a series of commits.

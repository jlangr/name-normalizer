package authornames_test

import (
    authornames "github.com/jlangr/name-normalizer/golang"
    "testing"
)

// To enable a test just change the first letter of the test function to upper case,
// so that your function's name begins with 'Test'.
//
// To run the tests just run 'go test' in the terminal.

func test_ShouldReturnEmptyString_WhenNameIsEmpty(t *testing.T) {
    expected := ""
    actual, err := authornames.Normalize("")
    if err != nil {
        t.Fatal(err)
    }
    if expected != actual {
        t.Fatalf("expected: '%v', actual: '%v'", expected, actual)
    }
}

func test_ShouldReturnSingleWordName(t *testing.T) {
    expected := "Plato"
    actual, err := authornames.Normalize("Plato")
    if err != nil {
        t.Fatal(err)
    }
    if expected != actual {
        t.Fatalf("expected: '%v', actual: '%v'", expected, actual)
    }
}

func test_ShouldSwapFirstAndLastNames(t *testing.T) {
    expected := "Murakami, Haruki"
    actual, err := authornames.Normalize("Haruki Murakami")
    if err != nil {
        t.Fatal(err)
    }
    if expected != actual {
        t.Fatalf("expected: '%v', actual: '%v'", expected, actual)
    }
}

func test_ShouldTrimLeadingAndTrailingWhitespaces(t *testing.T) {
    expected := "Boi, Big"
    actual, err := authornames.Normalize("  Big Boi   ")
    if err != nil {
        t.Fatal(err)
    }
    if expected != actual {
        t.Fatalf("expected: '%v', actual: '%v'", expected, actual)
    }
}

func test_ShouldInitializeMiddleName(t *testing.T) {
    expected := "Thoreau, Henry D."
    actual, err := authornames.Normalize("Henry David Thoreau")
    if err != nil {
        t.Fatal(err)
    }
    if expected != actual {
        t.Fatalf("expected: '%v', actual: '%v'", expected, actual)
    }
}

func test_ShouldNotInitializeMiddleName_WhenMiddleNameIsOneLetter(t *testing.T) {
    expected := "Truman, Harry S"
    actual, err := authornames.Normalize("Harry S Truman")
    if err != nil {
        t.Fatal(err)
    }
    if expected != actual {
        t.Fatalf("expected: '%v', actual: '%v'", expected, actual)
    }
}

func test_ShouldInitializeEachOfMultipleMiddleNames(t *testing.T) {
    expected := "Louis-Dreyfus, Julia S. E."
    actual, err := authornames.Normalize("Julia Scarlett Elizabeth Louis-Dreyfus")
    if err != nil {
        t.Fatal(err)
    }
    if expected != actual {
        t.Fatalf("expected: '%v', actual: '%v'", expected, actual)
    }
}

func test_ShouldAppendSuffixesToEnd(t *testing.T) {
    expected := "King, Martin L., Jr."
    actual, err := authornames.Normalize("Martin Luther King, Jr.")
    if err != nil {
        t.Fatal(err)
    }
    if expected != actual {
        t.Fatalf("expected: '%v', actual: '%v'", expected, actual)
    }
}

func test_ShouldReturnAnError_WhenNameContainsTwoCommas(t *testing.T) {
    _, err := authornames.Normalize("Thurston, Howell, III")
    if err == nil {
        t.Fatal("expected an error, but nothing went wrong ...")
    }
}

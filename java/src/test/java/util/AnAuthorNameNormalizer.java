package util;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;

// 1. Un-ignore the next commented-out test method.
// 2. Run JUnit against *all* tests in the project.
// 3. Did the current test fail? If not: You built too much code in a prior step. Undo work for prior tests and try again.
// 4. Make sure you are clear on why the test failed.
// 5. Write only enough code to make that failing test pass (and not break any other tests).
//    Did you write too much? Is there a simple way to get that test to pass???
// 6. If there is a commented-out assertion, uncomment it. It should fail. If not, return to step 5.
// 7. Repeat prior steps until no more test methods exist.

public class AnAuthorNameNormalizer {
    private AuthorNameNormalizer normalizer =
            new AuthorNameNormalizer();

    @Test
    public void returnsEmptyStringWhenEmpty() {
        assertThat(normalizer.normalize(""),
                is(equalTo("")));
    }

    @Disabled
    @Test
    public void returnsSingleWordName() {
        assertThat(normalizer.normalize("Plato"),
                is(equalTo("Plato")));
    }

    @Disabled
    @Test
    public void swapsFirstAndLastNames() {
      assertThat(normalizer.normalize("Haruki Murakami"),
              is(equalTo("Murakami, Haruki")));
    }

    @Disabled
    @Test
    public void trimsLeadingAndTrailingWhitespace() {
        assertThat(normalizer.normalize("  Big Boi   "),
                is(equalTo("Boi, Big")));
    }

    @Disabled
    @Test
    public void initializesMiddleName() {
        assertThat(normalizer.normalize("Henry David Thoreau"),
                is(equalTo("Thoreau, Henry D.")));
    }

    @Disabled
    @Test
    public void doesNotInitializeOneLetterMiddleName() {
        assertThat(normalizer.normalize("Harry S Truman"),
                is(equalTo("Truman, Harry S")));
    }

    @Disabled
    @Test
    public void initializesEachOfMultipleMiddleNames() {
        assertThat(normalizer.normalize("Julia Scarlett Elizabeth Louis-Dreyfus"),
                is(equalTo("Louis-Dreyfus, Julia S. E.")));
    }

    @Disabled
    @Test
    public void appendsSuffixesToEnd() {
        assertThat(normalizer.normalize("Martin Luther King, Jr."),
                is(equalTo("King, Martin L., Jr.")));
    }

    @Disabled
    @Test
    public void throwsWhenNameContainsTwoCommas() {
        assertThrows(IllegalArgumentException.class, () -> {
            normalizer.normalize("Thurston, Howell, III");
        });
    }
}

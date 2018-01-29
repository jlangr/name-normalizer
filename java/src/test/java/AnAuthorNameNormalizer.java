package util;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import static org.hamcrest.Matchers.equalTo;
import static org.junit.Assert.assertThat;

// 1. Un-ignore the next commented-out test method.
// 2. Run JUnit against *all* tests in the project.
// 3. Did the current test fail? If not: You built too much code in a prior step. Undo work for prior tests and try again.
// 4. Make sure you are clear on why the test failed.
// 5. Write only enough code to make that failing test pass (and not break any other tests).
//    Did you write too much? Is there a simple way to get that test to pass???
// 6. If there is a commented-out assertion, uncomment it. It should fail. If not, return to step 5.
// 7. Return to step 1.

public class AnAuthorNameNormalizer {
    private AuthorNameNormalizer normalizer;

    @Before
    public void create() {
        normalizer = new AuthorNameNormalizer();
    }

    @Test
    public void returnsEmptyStringWhenEmpty() {
        assertThat(normalizer.normalize(""), equalTo(""));
    }

    @Test
    public void returnsSingleWordName() {
        assertThat(normalizer.normalize("Plato"), equalTo("Plato"));
    }

    @Test
    public void swapsFirstAndLastNames() {
      assertThat(normalizer.normalize("Haruki Murakami"), equalTo("Murakami, Haruki"));
    }

    @Test
    public void trimsLeadingAndTrailingWhitespace() {
        assertThat(normalizer.normalize("  Big Boi   "), equalTo("Boi, Big"));
    }

    @Test
    public void initializesMiddleName() {
        assertThat(normalizer.normalize("Henry David Thoreau"), equalTo("Thoreau, Henry D."));
    }

    @Test
    public void doesNotInitializeOneLetterMiddleName() {
        assertThat(normalizer.normalize("Harry S Truman"), equalTo("Truman, Harry S"));
    }

    @Test
    public void initializesEachOfMultipleMiddleNames() {
        assertThat(normalizer.normalize("Julia Scarlett Elizabeth Louis-Dreyfus"), equalTo("Louis-Dreyfus, Julia S. E."));
    }

    @Test
    public void appendsSuffixesToEnd() {
        assertThat(normalizer.normalize("Martin Luther King, Jr."), equalTo("King, Martin L., Jr."));
    }

    @Test(expected = IllegalArgumentException.class)
    public void throwsWhenNameContainsTwoCommas() {
        normalizer.normalize("Thurston, Howell, III");
    }
    
    // uppercase middle init?
}

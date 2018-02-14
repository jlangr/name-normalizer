package util;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;

public class AnAuthorNameNormalizer {
    private AuthorNameNormalizer normalizer =
            new AuthorNameNormalizer();

    @Test
    public void returnsEmptyStringWhenEmpty() {
        assertThat(normalizer.normalize(""),
                is(equalTo("")));
    }

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

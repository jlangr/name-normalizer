package util;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class AnAuthorNameNormalizer {
    private AuthorNameNormalizer normalizer = new AuthorNameNormalizer();

    @Test
    public void returnsEmptyStringWhenEmpty() {
        assertThat(normalizer.normalize(""))
                .isEqualTo("");
    }

    @Test
    public void returnsSingleWordName() {
        assertThat(normalizer.normalize("Plato"))
                .isEqualTo("Plato");
    }

    @Test
    public void swapsFirstAndLastNames() {
      assertThat(normalizer.normalize("Haruki Murakami"))
              .isEqualTo("Murakami, Haruki");
    }

    @Test
    public void trimsLeadingAndTrailingWhitespace() {
        assertThat(normalizer.normalize("  Big Boi   "))
                .isEqualTo("Boi, Big");
    }

    @Disabled
    @Test
    public void initializesMiddleName() {
        assertThat(normalizer.normalize("Henry David Thoreau"))
                .isEqualTo("Thoreau, Henry D.");
    }

    @Disabled
    @Test
    public void doesNotInitializeOneLetterMiddleName() {
        assertThat(normalizer.normalize("Harry S Truman"))
                .isEqualTo("Truman, Harry S");
    }

    @Disabled
    @Test
    public void initializesEachOfMultipleMiddleNames() {
        assertThat(normalizer.normalize("Julia Scarlett Elizabeth Louis-Dreyfus"))
                .isEqualTo("Louis-Dreyfus, Julia S. E.");
    }

    @Disabled
    @Test
    public void appendsSuffixesToEnd() {
        assertThat(normalizer.normalize("Martin Luther King, Jr."))
                .isEqualTo("King, Martin L., Jr.");
    }

    @Disabled
    @Test
    public void throwsWhenNameContainsTwoCommas() {
        assertThatThrownBy(() -> {
            normalizer.normalize("Thurston, Howell, III");
        }).isInstanceOf(IllegalArgumentException.class);
    }
}

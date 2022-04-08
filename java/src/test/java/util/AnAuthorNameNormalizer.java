package util;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

class AnAuthorNameNormalizer {
    AuthorNameNormalizer normalizer = new AuthorNameNormalizer();

    @Test
    void returnsEmptyStringWhenEmpty() {
        assertThat(normalizer.normalize(""))
                .isEmpty();
    }

    @Disabled("uncomment when ready")
    @Test
    void returnsSingleWordName() {
        assertThat(normalizer.normalize("Plato"))
                .isEqualTo("Plato");
    }

    @Disabled("uncomment when ready")
    @Test
    void swapsFirstAndLastNames() {
      assertThat(normalizer.normalize("Haruki Murakami"))
              .isEqualTo("Murakami, Haruki");
    }

    @Disabled("uncomment when ready")
    @Test
    void trimsLeadingAndTrailingWhitespace() {
        assertThat(normalizer.normalize("  Big Boi   "))
                .isEqualTo("Boi, Big");
    }

    @Disabled("uncomment when ready")
    @Test
    void initializesMiddleName() {
        assertThat(normalizer.normalize("Henry David Thoreau"))
                .isEqualTo("Thoreau, Henry D.");
    }

    @Disabled("uncomment when ready")
    @Test
    void doesNotInitializeOneLetterMiddleName() {
        assertThat(normalizer.normalize("Harry S Truman"))
                .isEqualTo("Truman, Harry S");
    }

    @Disabled("uncomment when ready")
    @Test
    void initializesEachOfMultipleMiddleNames() {
        assertThat(normalizer.normalize("Julia Scarlett Elizabeth Louis-Dreyfus"))
                .isEqualTo("Louis-Dreyfus, Julia S. E.");
    }

    @Disabled("uncomment when ready")
    @Test
    void appendsSuffixesToEnd() {
        assertThat(normalizer.normalize("Martin Luther King, Jr."))
                .isEqualTo("King, Martin L., Jr.");
    }

    @Disabled("uncomment when ready")
    @Test
    void throwsWhenNameContainsTwoCommas() {
        assertThatThrownBy(() -> normalizer.normalize("Thurston, Howell, III"))
                .isInstanceOf(IllegalArgumentException.class);
    }
}

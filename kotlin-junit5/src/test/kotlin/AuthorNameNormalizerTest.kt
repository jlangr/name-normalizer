import org.assertj.core.api.Assertions.*
import org.junit.jupiter.api.Disabled
import org.junit.jupiter.api.Test

class AuthorNameNormalizerTest {
    private val normalizer = AuthorNameNormalizer()

    @Test
    fun `returns empty string when empty`() {
        assertThat(normalizer.normalize(""))
            .isEqualTo("")
    }

    @Test
    fun `returns single word name`() {
        assertThat(normalizer.normalize("Plato"))
            .isEqualTo("Plato")
    }

    @Test
    fun `swaps first and last names`() {
        assertThat(normalizer.normalize("Haruki Murakami"))
            .isEqualTo("Murakami, Haruki")
    }

    @Test
    fun `trims leading and trailing whitespace`() {
        assertThat(normalizer.normalize("  Big Boi   "))
            .isEqualTo("Boi, Big")
    }

    @Test
    fun `initializes middle name`() {
        assertThat(normalizer.normalize("Henry David Thoreau"))
            .isEqualTo("Thoreau, Henry D.")
    }

    @Test
    fun `does not initialize one letter middle name`() {
        assertThat(normalizer.normalize("Harry S Truman"))
            .isEqualTo("Truman, Harry S")
    }

    @Test
    fun `initializes each of multiple middle names`() {
        assertThat(normalizer.normalize("Julia Scarlett Elizabeth Louis-Dreyfus"))
            .isEqualTo("Louis-Dreyfus, Julia S. E.")
    }

    @Test
    fun `appends suffixes to end`() {
        assertThat(normalizer.normalize("Martin Luther King, Jr."))
            .isEqualTo("King, Martin L., Jr.")
    }

    @Disabled
    @Test
    fun `throws when name contains two commas`() {
        assertThatExceptionOfType(IllegalArgumentException::class.java)
            .isThrownBy { normalizer.normalize("Thurston, Howell, III") }
            .withMessage("name contains two commas")
    }
}
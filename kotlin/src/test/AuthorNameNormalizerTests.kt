import kotlin.test.assertFailsWith
import org.hamcrest.CoreMatchers.equalTo
import org.hamcrest.MatcherAssert.assertThat
import org.junit.Before
import org.junit.Ignore
import org.junit.Test

class AuthorNameNormalizerTests {
    private lateinit var normalizer: AuthorNameNormalizer

    @Before
    fun setUp() {
        normalizer = AuthorNameNormalizer()
    }

    @Test
    fun `returns empty string when empty`() {
        assertThat(
            normalizer.normalize(""),
            equalTo("")
        )
    }

    @Ignore
    @Test
    fun `returns single word name`() {
        assertThat(
            normalizer.normalize("Plato"),
            equalTo("Plato")
        )
    }

    @Ignore
    @Test
    fun `swaps first and last names`() {
        assertThat(
            normalizer.normalize("Haruki Murakami"),
            equalTo("Murakami, Haruki")
        )
    }

    @Ignore
    @Test
    fun `trims leading and trailing whitespace`() {
        assertThat(
            normalizer.normalize("  Big Boi   "),
            equalTo("Boi, Big")
        )
    }

    @Ignore
    @Test
    fun `initializes middle name`() {
        assertThat(
            normalizer.normalize("Henry David Thoreau"),
            equalTo("Thoreau, Henry D.")
        )
    }

    @Ignore
    @Test
    fun `does not initialize one letter middle name`() {
        assertThat(
            normalizer.normalize("Harry S Truman"),
            equalTo("Truman, Harry S")
        )
    }

    @Ignore
    @Test
    fun `initializes each of multiple middle names`() {
        assertThat(
            normalizer.normalize("Julia Scarlett Elizabeth Louis-Dreyfus"),
            equalTo("Louis-Dreyfus, Julia S. E.")
        )
    }

    @Ignore
    @Test
    fun `appends suffixes to end`() {
        assertThat(
            normalizer.normalize("Martin Luther King, Jr."),
            equalTo("King, Martin L., Jr.")
        )
    }

    @Ignore
    @Test
    fun `throws when name contains two commas`() {
        assertFailsWith(IllegalArgumentException::class) {
            normalizer.normalize("Thurston, Howell, III")
        }
    }
}

import unittest

from name_normalizer import normalize


class NameNormalizerTests(unittest.TestCase):

    def test_returns_empty_string(self):
        self.assertEqual(normalize(""), "")

    @unittest.skip
    def test_returns_single_word_name(self):
        self.assertEqual(normalize("Plato"), "Plato")

    @unittest.skip
    def test_swaps_first_and_last_names(self):
        self.assertEqual(normalize("Haruki Murakami"), "Murakami, Haruki")

    @unittest.skip
    def test_trims_leading_and_trailing_whitespaces(self):
        self.assertEqual(normalize("  Big Boi   "), "Boi, Big")

    @unittest.skip
    def test_initializes_middle_name(self):
        self.assertEqual(normalize("Henry David Thoreau"), "Thoreau, Henry D.")

    @unittest.skip
    def test_does_not_initialize_one_letter_middle_name(self):
        self.assertEqual(normalize("Harry S Truman"), "Truman, Harry S")

    @unittest.skip
    def test_initializes_each_of_multiple_middle_names(self):
        self.assertEqual(
            normalize("Julia Scarlett Elizabeth Louis-Dreyfus"),
            "Louis-Dreyfus, Julia S. E.",
        )

    @unittest.skip
    def test_appends_suffixes_to_end(self):
        self.assertEqual(normalize("Martin Luther King, Jr."), "King, Martin L., Jr.")

    @unittest.skip
    def test_returns_an_error_when_name_contains_two_commas(self):
        with self.assertRaises(ValueError):
            normalize("Thurston, Howell, III")


if __name__ == "__main__":
    unittest.main()

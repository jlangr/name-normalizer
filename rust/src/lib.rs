const MULTIPLE_COMMAS_ERR_MSG: &'static str = "multiple commas are not allowed";

#[allow(dead_code)]
fn normalize<'a, 'b>(name: &'a str) -> Result<String, &'b str> {
    todo!("not implemented")
}

#[cfg(test)]
mod tests {
    use super::*;

    #[ignore]
    #[test]
    fn returns_empty_string() {
        assert_eq!(normalize("").unwrap(), "");
    }

    #[ignore]
    #[test]
    fn returns_single_word_name() {
        assert_eq!(normalize("Plato").unwrap(), "Plato");
    }

    #[ignore]
    #[test]
    fn swaps_first_and_last_names() {
        assert_eq!(normalize("Haruki Murakami").unwrap(), "Murakami, Haruki");
    }

    #[ignore]
    #[test]
    fn trims_leading_and_trailing_whitespaces() {
        assert_eq!(normalize("  Big Boi   ").unwrap(), "Boi, Big");
    }

    #[ignore]
    #[test]
    fn initializes_middle_name() {
        assert_eq!(
            normalize("Henry David Thoreau").unwrap(),
            "Thoreau, Henry D."
        );
    }

    #[ignore]
    #[test]
    fn does_not_initialize_one_letter_middle_name() {
        assert_eq!(normalize("Harry S Truman").unwrap(), "Truman, Harry S");
    }

    #[ignore]
    #[test]
    fn initializes_each_of_multiple_middle_names() {
        assert_eq!(
            normalize("Julia Scarlett Elizabeth Louis-Dreyfus").unwrap(),
            "Louis-Dreyfus, Julia S. E."
        );
    }

    #[ignore]
    #[test]
    fn appends_suffixes_to_end() {
        assert_eq!(
            normalize("Martin Luther King, Jr.").unwrap(),
            "King, Martin L., Jr."
        );
    }

    #[ignore]
    #[test]
    fn returns_an_error_when_name_contains_two_commas() {
        assert_eq!(
            normalize("Thurston, Howell, III"),
            Err(MULTIPLE_COMMAS_ERR_MSG)
        );
    }
}

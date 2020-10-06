package authornames

import (
    "strings"
)

func Normalize(s string) (string, error) {
    if isSingleWordName(s) {
        return s, nil
    }

    parts := strings.Split(s, " ")
    firstName := determineFirstName(parts)
    lastName := determineLastName(parts)
    result := lastName + ", " + firstName

    return result, nil
}

func determineLastName(parts []string) string {
    return parts[1]
}

func determineFirstName(parts []string) string {
    return parts[0]
}

func isSingleWordName(s string) bool {
    return !strings.Contains(s, " ")
}

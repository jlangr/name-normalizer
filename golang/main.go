package authornames

import (
    "strings"
)

func Normalize(s string) (string, error) {
    s = strings.TrimSpace(s)

    if isSingleWordName(s) {
        return s, nil
    }

    parts := strings.Split(s, " ")
    firstName := determineFirstName(parts)
    middleName := determineMiddleName(parts)
    middleName = convertToInitializedFormat(middleName)
    lastName := determineLastName(parts)

    result := lastName + ", " + firstName
    if middleName != "" {
        result += " " + middleName
    }

    return result, nil
}

func convertToInitializedFormat(name string) string {
    if name == "" {
        return ""
    }

    return string(name[0]) + "."
}

func determineMiddleName(parts []string) string {
    if len(parts) == 3 {
        return parts[1]
    }

    return ""
}

func determineLastName(parts []string) string {
    return parts[len(parts)-1]
}

func determineFirstName(parts []string) string {
    return parts[0]
}

func isSingleWordName(s string) bool {
    return !strings.Contains(s, " ")
}

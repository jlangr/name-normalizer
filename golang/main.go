package authornames

import (
    "strings"
)

type authorName struct {
    firstName  string
    middleName string
    lastName   string
}

func (n authorName) getMiddleNameAsInitializedString() string {
    if n.middleName == "" {
        return ""
    }

    return string(n.middleName[0]) + "."
}

func (n authorName) String() string {
    result := n.lastName + ", " + n.firstName

    if n.middleName != "" {
        result += " " + n.getMiddleNameAsInitializedString()
    }

    return result
}

func Normalize(s string) (string, error) {
    s = strings.TrimSpace(s)

    if isSingleWordName(s) {
        return s, nil
    }

    name := parseAuthorName(s)

    return name.String(), nil
}

func parseAuthorName(s string) authorName {
    parts := strings.Split(s, " ")

    return authorName{
        firstName:  determineFirstName(parts),
        middleName: determineMiddleName(parts),
        lastName:   determineLastName(parts),
    }
}

func determineMiddleName(parts []string) string {
    if parts == nil || len(parts) < 3 {
        return ""
    }

    return parts[1]
}

func determineLastName(parts []string) string {
    if parts == nil || len(parts) == 0 {
        return ""
    }

    return parts[len(parts)-1]
}

func determineFirstName(parts []string) string {
    if parts == nil || len(parts) == 0 {
        return ""
    }

    return parts[0]
}

func isSingleWordName(s string) bool {
    return !strings.Contains(s, " ")
}

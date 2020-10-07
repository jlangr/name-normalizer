package authornames

import (
    "strings"
)

type authorName struct {
    firstName   string
    middleNames []string
    lastName    string
}

func (n authorName) getMiddleNamesAsInitializedString() string {
    if n.middleNames == nil || len(n.middleNames) == 0 {
        return ""
    }

    result := ""
    for _, v := range n.middleNames {
        if len(v) == 1 {
            result += v + " "
        } else {
            result += string(v[0]) + ". "
        }
    }

    return strings.TrimSpace(result)
}

func (n authorName) String() string {
    result := n.lastName + ", " + n.firstName

    if n.middleNames != nil && len(n.middleNames) > 0 {
        result += " " + n.getMiddleNamesAsInitializedString()
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
        firstName:   determineFirstName(parts),
        middleNames: determineMiddleNames(parts),
        lastName:    determineLastName(parts),
    }
}

func determineMiddleNames(parts []string) []string {
    if parts == nil || len(parts) < 3 {
        return nil
    }

    return parts[1 : len(parts)-1]
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

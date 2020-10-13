package authornames

import (
	"fmt"
	"strings"
)

func Normalize(s string) (string, error) {
	s = strings.TrimSpace(s)

	if isSingleWordName(s) {
		return s, nil
	}

	name, err := parseAuthorName(s)
	if err != nil {
		return "", err
	}

	return name.String(), nil
}

func parseAuthorName(s string) (*authorName, error) {
	name, suffix, err := splitNameFromSuffix(s)
	if err != nil {
		return nil, err
	}

	parts := strings.Split(name, " ")

	return &authorName{
		firstName:   determineFirstName(parts),
		middleNames: determineMiddleNames(parts),
		lastName:    determineLastName(parts),
		suffix:      suffix,
	}, nil
}

func splitNameFromSuffix(s string) (string, string, error) {
	if strings.Count(s, ",") > 1 {
		return "", "", fmt.Errorf("there are too much commas in '%v'", s)
	}

	name := s
	suffix := ""
	if strings.Contains(s, ",") {
		parts := strings.Split(s, ",")
		name = strings.TrimSpace(parts[0])
		suffix = strings.TrimSpace(parts[1])
	}

	return name, suffix, nil
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

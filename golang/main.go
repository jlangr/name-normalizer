package authornames

import (
    "strings"
)

func Normalize(s string) (string, error) {
    result := s

    if strings.Contains(s, " ") {
        parts := strings.Split(s, " ")
        result = parts[1] + ", " + parts[0]
    }

    return result, nil
}

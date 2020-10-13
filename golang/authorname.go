package authornames

import "strings"

type authorName struct {
	firstName   string
	middleNames []string
	lastName    string
	suffix      string
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
	if n.suffix != "" {
		result += ", " + n.suffix
	}

	return result
}

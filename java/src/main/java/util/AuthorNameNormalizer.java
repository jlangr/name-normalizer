package util;

public class AuthorNameNormalizer {
    public String normalize(String name) {
        var parts = name.split(" ");
        if (parts.length == 1)
            return name;
        return parts[1] + ", " + parts[0];
    }
}

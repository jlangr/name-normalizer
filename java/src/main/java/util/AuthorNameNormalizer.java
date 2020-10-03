package util;

public class AuthorNameNormalizer {
    public String normalize(String name) {
        var parts = name.split(" ");
        if (isMononym(parts))
            return name;
        return last(parts) + ", " + first(parts);
    }

    private boolean isMononym(String[] parts) {
        return parts.length == 1;
    }

    private String first(String[] parts) {
        return parts[0];
    }

    private String last(String[] parts) {
        return parts[1];
    }
}

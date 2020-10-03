package util;

public class AuthorNameNormalizer {
    private String[] parts;

    public String normalize(String name) {
        parse(name.trim());
        if (isMononym())
            return name;
        return last() + ", " + first();
    }

    private void parse(String name) {
        parts = name.split(" ");
    }

    private boolean isMononym() {
        return parts.length == 1;
    }

    private String first() {
        return parts[0];
    }

    private String last() {
        return parts[1];
    }
}

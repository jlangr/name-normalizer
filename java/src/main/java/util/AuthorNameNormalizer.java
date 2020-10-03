package util;

public class AuthorNameNormalizer {
    private String[] parts;

    public String normalize(String name) {
        parse(name.trim());
        if (isMononym())
            return name;
        if (isDuonym())
            return formatDuonym();
        return formatMultiPartName();
    }

    private String formatMultiPartName() {
        return last() + ", " + first() +  " " + middleInitial();
    }

    private String middleInitial() {
        return middle().charAt(0) +
                (middle().length() == 1 ? "" : ".");
    }

    private String middle() {
        return parts[1];
    }

    private boolean isDuonym() {
        return parts.length == 2;
    }

    private String formatDuonym() {
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
        return parts[parts.length - 1];
    }
}

package util;

import java.util.Arrays;
import java.util.stream.Collectors;

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
        return last() + ", " + first() +  " " + middleInitials();
    }

    private String middleInitials() {
        return Arrays.stream(parts)
                .skip(1)
                .limit(parts.length - 2)
                .map(this::initial)
                .collect(Collectors.joining(" "));
    }


    private String initial(String name) {
        return name.charAt(0) +
                (name.length() == 1 ? "" : ".");
    }

    private String formatDuonym() {
        return last() + ", " + first();
    }

    private boolean isDuonym() {
        return parts.length == 2;
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

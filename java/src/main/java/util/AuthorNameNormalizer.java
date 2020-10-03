package util;

import java.util.Arrays;
import java.util.stream.Collectors;

public class AuthorNameNormalizer {
    private String[] parts;
    private String trimmedName;
    private String baseName;
    private String suffix;

    public String normalize(String name) {
        parse(name.trim());
        if (isMononym())
            return formatMononym();
        if (isDuonym())
            return formatDuonym();
        return formatMultiPartName();
    }

    private String formatMononym() {
        return trimmedName;
    }

    private String formatMultiPartName() {
        return last() + ", " + first() + " " + middleInitials() + suffix();
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
        return last() + ", " + first() + suffix();
    }

    private boolean isDuonym() {
        return parts.length == 2;
    }

    private void parse(String name) {
        trimmedName = name;
        deriveBaseNameAndSuffix();
        parts = baseName.split(" ");
    }

    private void deriveBaseNameAndSuffix() {
        var parts = trimmedName.split(",");
        baseName = parts[0];
        if (parts.length == 2)
            suffix = parts[1];
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

    private String suffix() {
        if (suffix == null)
            return "";
        return "," + suffix;
    }
}

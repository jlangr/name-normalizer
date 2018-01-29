package util;

public class AuthorNameNormalizer {
    public String normalize(String name) {
    		throwWhenContainsTooManyCommas(name);
    		String[] parts = suffixless(name).trim().split(" ");
        if (isMononym(parts))
            return name;
        return lastName(parts) + ", " + firstName(parts) + 
        		middleInitials(parts) + suffix(name);
    }

	private void throwWhenContainsTooManyCommas(String name) {
		if (count(name, ',') > 1)
			throw new IllegalArgumentException();
		
	}
	private String suffixless(String name) {
		if(hasComma(name))
			return name.substring(0, name.indexOf(','));
		return name;
	}
	
	private boolean hasComma(String name) {
		return name.contains(",");
	}
	
	private String suffix(String name) {
		if(hasComma(name))
			return name.substring(name.indexOf(','));
		return "";
	}

    private String middleInitials(String[] parts) {
    		if (parts.length <= 2)
    			return "";
    		
    		String middleInitials = "";
    		for(int i = 1; i < parts.length - 1; i ++){
    			middleInitials += " " + initial(parts[i]);
    		}
    		
		return middleInitials;
	}

	private String initial(String name) {
		if(name.length() == 1) return name;
		return name.charAt(0) + ".";
	}

    
	private boolean isMononym(String[] parts) {
        return parts.length == 1;
    }

    private String firstName(String[] parts) {
        return parts[0];
    }

    private String lastName(String[] parts) {
        return parts[parts.length - 1];
    }

    // See http://stackoverflow.com/questions/275944/java-how-do-i-count-the-number-of-occurrences-of-a-char-in-a-string
    // ... if you need to convert to < Java 8
   /* private */ long count(String string, char c) {
        return string.chars().filter(ch -> ch == c).count();
    }
}


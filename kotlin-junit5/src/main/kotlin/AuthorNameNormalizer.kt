class AuthorNameNormalizer {
    fun normalize(s: String): String {
        if (s.contains(' ')) {
            val parts = s.split(" ")
            return "${parts[1]}, ${parts[0]}"
        }
        return s
    }
}
class AuthorNameNormalizer {
    fun normalize(rawName: String): String {
        if (rawName.contains(' ')) {
            val parts = rawName.split(" ")
            return "${parts[1]}, ${parts[0]}"
        }
        return rawName
    }
}
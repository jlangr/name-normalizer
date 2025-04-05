class AuthorNameNormalizer {
    fun normalize(rawName: String): String {
        if (rawName.contains(' ')) {
            val parts = rawName.split(" ").filter { it.isNotBlank() }
            if (parts.size == 3) {
                return "${parts[2]}, ${parts[0]} ${parts[1].uppercase().first()}."
            } else {
                return "${parts[1]}, ${parts[0]}"
            }
        }
        return rawName
    }
}
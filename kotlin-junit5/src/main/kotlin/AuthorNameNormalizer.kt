class AuthorNameNormalizer {
    fun normalize(rawName: String): String {
        if (rawName.contains(' ')) {
            val parts = rawName.split(" ").filter { it.isNotBlank() }
            return if (parts.size == 3) {
                "${parts[2]}, ${parts[0]} ${parts[1].uppercase().first()}."
            } else {
                "${parts[1]}, ${parts[0]}"
            }
        }
        return rawName
    }
}
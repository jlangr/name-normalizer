class AuthorNameNormalizer {
    fun normalize(name: String): String {
        if (name.isMultiPart()) {
            val parts = name.split(' ')
            return "${parts[1]}, ${parts[0]}"
        }
        return name
    }

    private fun String.isMultiPart(): Boolean = contains(' ')
}
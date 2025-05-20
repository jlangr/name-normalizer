class AuthorNameNormalizer {
    fun normalize(name: String): String {
        if (isMultiPart(name)) {
            val parts = name.split(' ')
            return "${parts[1]}, ${parts[0]}"
        }
        return name
    }

    private fun isMultiPart(name: String): Boolean = name.contains(' ')
}
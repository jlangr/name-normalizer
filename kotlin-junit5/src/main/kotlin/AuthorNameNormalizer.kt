class AuthorNameNormalizer {
    fun normalize(rawName: String): String {
        return if (isMultipart(rawName)) {
            normalizeMultipart(rawName)
        } else
            rawName
    }

    private fun normalizeMultipart(rawName: String): String {
        val parts = rawName.split(" ").filter { it.isNotBlank() }
        return if (parts.size == 3) {
            "${parts[2]}, ${parts[0]} ${parts[1].uppercase().first()}."
        } else {
            "${parts[1]}, ${parts[0]}"
        }
    }

    private fun isMultipart(rawName: String) = rawName.contains(' ')
}
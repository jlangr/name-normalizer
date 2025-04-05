class AuthorNameNormalizer {
    fun normalize(rawName: String): String {
        return when {
            isMultipart(rawName) -> {
                normalizeMultipart(rawName)
            }
            else -> rawName
        }
    }

    private fun normalizeMultipart(rawName: String): String {
        val parts = rawName.split(" ").filter { it.isNotBlank() }
        return when {
            parts.size > 2 -> {
                val middleName = parts.dropLast(1).drop(1).map {
                    it.first().uppercase() + if (it.length > 1) "." else ""
                }.joinToString(" ")
                "${parts.last()}, ${parts.first()} $middleName"
            }
            else -> {
                "${parts[1]}, ${parts[0]}"
            }
        }
    }

    private fun isMultipart(rawName: String) = rawName.contains(' ')
}
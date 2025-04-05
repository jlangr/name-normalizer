class AuthorNameNormalizer {
    fun normalize(name: String): String = when {
        isMultipart(name) -> {
            normalizeMultipart(name)
        }
        else -> name
    }

    private fun normalizeMultipart(rawName: String): String {
        val parts = rawName.split(" ").filter { it.isNotBlank() }
        return when {
            hasSuffix(rawName) -> {
                val (mainName, suffix) = rawName.split(",")
                normalize(mainName) + ", ${suffix.trim()}"
            }
            hasMiddleName(parts) -> {
                val middleNames = parts.dropLast(1).drop(1).map {
                    it.first().uppercase() + if (it.length > 1) "." else ""
                }.joinToString(" ")

                "${parts.last()}, ${parts.first()} $middleNames"
            }
            else -> {
                "${parts[1]}, ${parts[0]}"
            }
        }
    }

    private fun hasSuffix(rawName: String) = rawName.contains(',')

    private fun hasMiddleName(parts: List<String>) = parts.size > 2

    private fun isMultipart(rawName: String) = rawName.contains(' ')
}
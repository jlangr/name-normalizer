class AuthorNameNormalizer {
    fun normalize(name: String): String = when {
        isMultipart(name) -> {
            normalizeMultipart(name)
        }

        else -> name
    }

    private fun normalizeMultipart(fullName: String): String {
        val parts = fullName.split(" ").filter { it.isNotBlank() }
        return when {
            hasSuffix(fullName) -> {
                val (mainPart, suffix) = fullName.split(",")
                normalize(mainPart) + ", ${suffix.trim()}"
            }

            hasMiddleName(parts) -> {
                val middleInitials = middle(parts).joinToString(" ") {
                    initialize(it)
                }

                "${parts.last()}, ${parts.first()} $middleInitials"
            }

            else -> {
                "${parts[1]}, ${parts[0]}"
            }
        }
    }

    private fun middle(parts: List<String>) = parts.dropLast(1).drop(1)

    private fun initialize(it: String) = it.first().uppercase() + if (it.length > 1) "." else ""

    private fun hasSuffix(name: String) = when (name.count { it == ',' }) {
        0 -> false
        1 -> true
        else -> throw IllegalArgumentException("name contains two commas")
    }

    private fun hasMiddleName(parts: List<String>) = parts.size > 2

    private fun isMultipart(name: String) = name.contains(' ')
}
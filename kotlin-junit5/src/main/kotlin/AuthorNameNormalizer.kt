class AuthorNameNormalizer {
    fun normalize(name: String): String = when {
        isMultipart(name) -> {
            normalizeMultipart(name)
        }

        else -> name
    }

    private fun isMultipart(name: String) = name.contains(' ')

    private fun normalizeMultipart(fullName: String): String {
        val parts = fullName.split(" ").filter { it.isNotBlank() }
        return when {
            hasSuffix(fullName) -> normalizeWithSuffix(fullName)
            hasMiddleName(parts) -> normalizeWithMiddleInitials(parts)
            else -> normalizeWithLastNameFirst(parts)
        }
    }

    private fun normalizeWithLastNameFirst(parts: List<String>) = "${parts[1]}, ${parts[0]}"

    private fun hasSuffix(name: String) = when (name.count { it == ',' }) {
        0 -> false
        1 -> true
        else -> throw IllegalArgumentException("name contains two commas")
    }

    private fun hasMiddleName(parts: List<String>) = parts.size > 2

    private fun normalizeWithSuffix(fullName: String): String {
        val (mainPart, suffix) = fullName.split(",")
        return normalize(mainPart) + ", ${suffix.trim()}"
    }

    private fun normalizeWithMiddleInitials(parts: List<String>): String {
        val middleInitials = middle(parts).joinToString(" ") {
            initialize(it)
        }
        return "${parts.last()}, ${parts.first()} $middleInitials"
    }

    private fun middle(names: List<String>) = names.dropLast(1).drop(1)

    private fun initialize(it: String) = it.first().uppercase() + if (it.length > 1) "." else ""
}
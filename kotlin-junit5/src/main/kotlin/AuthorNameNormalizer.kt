class AuthorNameNormalizer {
    fun normalize(name: String): String = when {
        isMultipart(name) -> normalizeMultipart(name)
        else -> name
    }

    private fun isMultipart(name: String) = name.contains(' ')

    private fun normalizeMultipart(fullName: String): String {
        val parts = fullName.split(" ").filter { it.isNotBlank() }
        return when {
            hasSuffix(fullName) -> appendSuffix(fullName)
            hasMiddleName(parts) -> appendMiddleInitials(parts)
            else -> putLastNameFirst(parts)
        }
    }

    private fun putLastNameFirst(parts: List<String>) = "${parts[1]}, ${parts[0]}"

    private fun hasSuffix(name: String) = when (name.count { it == ',' }) {
        0 -> false
        1 -> true
        else -> throw IllegalArgumentException("name contains two commas")
    }

    private fun appendSuffix(fullName: String): String {
        val (mainPart, suffix) = fullName.split(",")
        return normalize(mainPart) + ", ${suffix.trim()}"
    }

    private fun hasMiddleName(parts: List<String>) = parts.size > 2

    private fun appendMiddleInitials(parts: List<String>): String {
        val middleInitials = middle(parts).joinToString(" ") {
            initialize(it)
        }
        return "${parts.last()}, ${parts.first()} $middleInitials"
    }

    private fun middle(names: List<String>) = names.dropLast(1).drop(1)

    private fun initialize(it: String) = it.first().uppercase() + if (it.length > 1) "." else ""
}
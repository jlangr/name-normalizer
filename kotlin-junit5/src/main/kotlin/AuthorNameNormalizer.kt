class AuthorNameNormalizer {
    fun normalize(name: String): String = when {
        isMultipart(name) -> normalizeMultipart(name)
        else -> name
    }

    private fun isMultipart(name: String) = name.contains(' ')

    private fun normalizeMultipart(fullName: String): String {
        val parts = fullName.split(" ").filter { it.isNotBlank() }
        return when {
            hasSuffix(fullName) -> {
                val (mainPart, suffix) = fullName.split(",")
                "${normalize(mainPart)}, ${suffix.trim()}"
            }

            hasMiddleName(parts) -> "${putLastNameFirst(parts)} ${initialsOf(middle(parts))}"

            else -> putLastNameFirst(parts)
        }
    }

    private fun putLastNameFirst(parts: List<String>) = "${parts.last()}, ${parts.first()}"

    private fun hasSuffix(name: String) = when (name.count { it == ',' }) {
        0 -> false
        1 -> true
        else -> throw IllegalArgumentException("name contains two commas")
    }

    private fun hasMiddleName(parts: List<String>) = parts.size > 2

    private fun middle(names: List<String>) = names.dropLast(1).drop(1)

    private fun initialsOf(names: List<String>) = names.joinToString(" ") {
        it.first().uppercase() + if (it.length > 1) "." else ""
    }
}
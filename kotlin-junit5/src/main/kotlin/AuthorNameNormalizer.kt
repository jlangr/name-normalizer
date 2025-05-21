class AuthorNameNormalizer {
    fun normalize(authorName: String): String {
        val name = authorName.trim()
        return when {
            name.isMultiPart() -> {
                val (parts, suffix) = name.parts()
                val middleInitials = initialize(middle(parts))
                "${parts.last()}, ${parts.first()}$middleInitials$suffix"
            }
            else -> name
        }
    }

    private fun String.isMultiPart(): Boolean = contains(' ')

    private fun middle(parts: List<String>): List<String> = parts.drop(1).dropLast(1)

    private fun initialize(middleNames: List<String>): String = middleNames
        .joinToString(separator = " ", prefix = " ") {
            if (it.length > 1) "${it.first()}." else it
        }
        .ifBlank { "" }

    private fun String.parts() =
        when {
            hasSuffix() -> {
                rejectMultipleCommas()
                nameAndSuffix()
            }
            else -> {
                nameWithoutSuffix()
            }
        }

    private fun String.hasSuffix(): Boolean = contains(", ")

    private fun String.rejectMultipleCommas() {
        if (count { it == ',' } > 1) throw IllegalArgumentException("name contains two commas")
    }

    private fun String.nameAndSuffix(): Pair<List<String>, String> {
        val parts = split(", ")
        return parts[0].split(" ") to ", ${parts[1]}"
    }

    private fun String.nameWithoutSuffix(): Pair<List<String>, String> = split(' ') to ""
}
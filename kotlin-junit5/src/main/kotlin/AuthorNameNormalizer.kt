class AuthorNameNormalizer {
    fun normalize(authorName: String): String {
        val name = authorName.trim()
        if (name.isMultiPart()) {
            val (parts, suffix) = name.parts()
            val middleInitials = initialize(middle(parts))
            return "${parts.last()}, ${parts.first()}$middleInitials$suffix"
        }
        return name
    }

    private fun String.isMultiPart(): Boolean = contains(' ')

    private fun String.parts() =
        if (this.contains(", ")) {
            val parts = split(", ")
            parts[0].split(" ") to ", ${parts[1]}"
        } else {
            split(' ') to ""
        }

    private fun middle(parts: List<String>): List<String> = parts.drop(1).dropLast(1)

    private fun initialize(middleNames: List<String>): String = middleNames
        .joinToString(separator = " ", prefix = " ") {
            if (it.length > 1) "${it.first()}." else it
        }
        .ifBlank { "" }
}
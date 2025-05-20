class AuthorNameNormalizer {
    fun normalize(authorName: String): String {
        val name = authorName.trim()
        if (name.isMultiPart()) {
            val parts = name.parts()
            val middleInitial = middle(parts)
                .joinToString(separator = " ", prefix = " ") { "${it.first()}."}
                .ifBlank { "" }
            return "${parts.last()}, ${parts.first()}$middleInitial"        }
        return name
    }

    private fun middle(parts: List<String>): List<String> = parts.drop(1).dropLast(1)

    private fun String.parts(): List<String> = split(' ')

    private fun String.isMultiPart(): Boolean = contains(' ')
}
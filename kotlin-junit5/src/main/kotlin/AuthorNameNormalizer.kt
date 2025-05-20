class AuthorNameNormalizer {
    fun normalize(authorName: String): String {
        val name = authorName.trim()
        if (name.isMultiPart()) {
            val parts = name.parts()
            val middle = parts.drop(1).dropLast(1)
                .joinToString(separator = " ", prefix = " ") { "${it.first()}."}
                .ifBlank { "" }
            return "${parts.last()}, ${parts.first()}$middle"        }
        return name
    }

    private fun String.parts(): List<String> = split(' ')

    private fun String.isMultiPart(): Boolean = contains(' ')
}
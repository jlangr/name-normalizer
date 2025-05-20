class AuthorNameNormalizer {
    fun normalize(name: String): String {
        if (name.contains(' ')) {
            val parts = name.split(' ')
            return "${parts[1]}, ${parts[0]}"
        }
        return name
    }
}
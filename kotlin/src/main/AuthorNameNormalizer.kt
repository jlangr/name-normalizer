class AuthorNameNormalizer() {
    fun normalize(name: String): String {
        val nameParts = name.split(" ")
        if (nameParts.count() == 1) return name
        return nameParts.last() + ", " + nameParts.first()
    }
}

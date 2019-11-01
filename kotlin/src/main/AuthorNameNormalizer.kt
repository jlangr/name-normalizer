class AuthorNameNormalizer() {
    fun normalize(name: String): String {
        val nameParts = parts(name)
        if (nameParts.count() == 1) return name
        return "${nameParts.last()}, ${nameParts.first()}"
    }

    private fun parts(name: String) = name.trim().split(" ")
}

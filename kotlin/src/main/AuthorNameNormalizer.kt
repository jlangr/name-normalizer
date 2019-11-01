class AuthorNameNormalizer() {
    fun normalize(name: String): String {
        val nameParts = parts(name)
        if (isMononym(nameParts)) return name
        return "${nameParts.last()}, ${nameParts.first()}${middleInitial(nameParts)}"
    }

    private fun parts(name: String) = name.trim().split(" ")

    private fun isMononym(nameParts: List<String>) = nameParts.count() == 1

    private fun middleInitial(nameParts: List<String>): String {
        if (nameParts.count() <= 2) return ""
        val middleName = nameParts[1]
        return " " + middleName.first() + "."
    }
}

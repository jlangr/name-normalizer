class AuthorNameNormalizer() {
    fun normalize(name: String): String {
        val nameAndSuffix = name.split(",")
        val nameParts = parts(nameAndSuffix.first())
        if (isMononym(nameParts)) return name
        return "${nameParts.last()}, ${nameParts.first()}${middleInitials(nameParts)}${suffix(nameAndSuffix)}"
    }

    private fun suffix(nameAndSuffix: List<String>): String {
        return if (nameAndSuffix.count() == 1) "" else ",${nameAndSuffix.last()}"
    }

    private fun parts(name: String) = name.trim().split(" ")

    private fun isMononym(nameParts: List<String>) = nameParts.count() == 1

    private fun middleInitials(nameParts: List<String>): String {
        val middleNames = nameParts.drop(1).dropLast(1)
        return buildString {
            middleNames.forEach { append(initialized(it)) }
        }
    }

    private fun initialized(name: String): String {
        val period = if (name.count() > 1) "." else ""
        return " ${name.first()}$period"
    }
}

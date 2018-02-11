public func normalize(name: String) throws -> String {
    let prefixSuffix = name.split(separator: ",")
    let nameWithoutSuffix: String
    let suffix: String
    if prefixSuffix.count > 1 {
        nameWithoutSuffix = String(prefixSuffix.first!)
        suffix = ",\(prefixSuffix.last!)"
    } else {
        nameWithoutSuffix = name
        suffix = ""
    }
    let parts = nameWithoutSuffix.split(separator: " ")
    if parts.count < 2 {
        return nameWithoutSuffix
    }
    return "\(lastName(parts)), \(firstName(parts))\(middleInitial(parts))\(suffix)"
}

private func firstName(_ parts: [Substring]) -> String {
    return String(parts.first!)
}

private func lastName(_ parts: [Substring]) -> String {
    return String(parts.last!)
}

private func middleInitial(_ parts: [Substring]) -> String {
    let middleNames: ArraySlice<Substring> = parts[1 ..< parts.count - 1]
    return middleNames.map { initial(middleName: $0) }.joined()
}

private func initial(middleName: Substring) -> String {
    let period = middleName.count > 1 ? "." : ""
    return " \(middleName.first!)\(period)";
}

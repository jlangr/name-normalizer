public func normalize(name: String) throws -> String {
    let parts = name.split(separator: " ")
    if parts.count < 2 {
        return name
    }
    return "\(lastName(parts)), \(firstName(parts))\(middleInitial(parts))"
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

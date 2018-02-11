public func normalize(name: String) throws -> String {
    let parts = name.split(separator: " ")
    if parts.count < 2 {
        return name
    }
    return "\(parts.last!), \(parts.first!)\(middleInitial(parts: parts))"
}

private func middleInitial(parts: [Substring]) -> String {
    var middleInitial = ""
    if parts.count > 2 {
        middleInitial = " \(parts[1].first!)."
    }
    return middleInitial
}

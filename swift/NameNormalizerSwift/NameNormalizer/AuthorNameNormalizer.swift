public func normalize(name: String) throws -> String {
    let parts = name.split(separator: " ")
    if parts.count < 2 {
        return name
    }
    return "\(parts.last!), \(parts.first!)\(middleInitial(parts))"
}

private func middleInitial(_ parts: [Substring]) -> String {
    if parts.count > 2 {
        return " \(parts[1].first!)."
    } else {
        return ""
    }
}

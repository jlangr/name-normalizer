public func normalize(name: String) throws -> String {
    let parts = name.split(separator: " ")
    if parts.count < 2 {
        return name
    }
    let aMiddleInitial = middleInitial(parts: parts)
    return "\(parts.last!), \(parts.first!)\(aMiddleInitial)"
}

private func middleInitial(parts: [Substring]) -> String {
    var middleInitial = ""
    if parts.count > 2 {
        middleInitial = " \(parts[1].first!)."
    }
    return middleInitial
}

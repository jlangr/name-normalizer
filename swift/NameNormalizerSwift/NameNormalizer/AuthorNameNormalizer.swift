public func normalize(name: String) throws -> String {
    let parts = name.split(separator: " ")
    if parts.count > 2 {
        let middleInitial = parts[1].first!
        return "\(parts.last!), \(parts.first!) \(middleInitial)."
    }
    if parts.count > 1 {
        return "\(parts.last!), \(parts.first!)"
    }
    return name
}

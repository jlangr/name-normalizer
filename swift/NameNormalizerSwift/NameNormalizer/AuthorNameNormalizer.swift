public func normalize(name: String) throws -> String {
    let parts = name.split(separator: " ")
    if parts.count < 2 {
        return name
    }
    if parts.count > 2 {
        let middleInitial = parts[1].first!
        return "\(parts.last!), \(parts.first!) \(middleInitial)."
    }
    return "\(parts.last!), \(parts.first!)"
}

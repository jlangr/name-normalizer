public func normalize(name: String) throws -> String {
    let parts = name.components(separatedBy: " ")
    if parts.count > 1 {
        return "\(parts.last!), \(parts.first!)"
    }
    return name
}

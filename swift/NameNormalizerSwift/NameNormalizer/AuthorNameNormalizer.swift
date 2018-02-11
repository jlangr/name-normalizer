public func normalize(name: String) throws -> String {
    let parts = name.split(separator: " ")
    if parts.count < 2 {
        return name
    }
    return "\(lastName(parts)), \(firstName(parts))\(middleInitial(parts))"
}

private func firstName(_ parts: [Substring]) -> Substring {
    return parts.first!
}

private func lastName(_ parts: [Substring]) -> Substring {
    return parts.last!
}

private func middleInitial(_ parts: [Substring]) -> String {
    if parts.count > 2 {
        return " \(parts[1].first!)."
    } else {
        return ""
    }
}

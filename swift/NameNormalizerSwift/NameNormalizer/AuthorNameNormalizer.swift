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
    if parts.count > 2 {
        let middleName = parts[1]
        var period = ""
        if middleName.count > 1 {
            period = "."
        }
        return " \(middleName.first!)\(period)"
    } else {
        return ""
    }
}

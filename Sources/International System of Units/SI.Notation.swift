extension SI {
    public enum Notation {
    }
}

extension SI.Notation {
    public enum Marker: String, Sendable {
        case point = "."
        case comma = ","
    }

    public static func decimal(_ text: String, marker: Marker = .point) throws(Error) -> String {
        guard !text.isEmpty else { throw .syntax }
        var characters = Array(text)
        var sign = ""
        if characters.first == "-" || characters.first == "+" { sign = String(characters.removeFirst()) }
        guard !characters.isEmpty else { throw .syntax }
        let parts = String(characters).split(separator: Character(marker.rawValue), omittingEmptySubsequences: false)
        guard parts.count <= 2, !parts[0].isEmpty,
            parts.allSatisfy({ !$0.isEmpty && $0.allSatisfy { $0.isASCII && $0.isNumber } })
        else { throw .syntax }
        return sign + parts.map(String.init).joined(separator: marker.rawValue)
    }
}

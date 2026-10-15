internal import Rational

extension SI.Unit {
    public var symbol: String? {
        if factors.isEmpty { return "1" }
        var pieces: [String] = []
        for (factor, power) in factors {
            guard let symbol = factor.symbol else { return nil }
            pieces.append(symbol + Self.superscript(power))
        }
        return pieces.sorted().joined(separator: "⋅")
    }
    internal static func superscript(_ power: Rational) -> String {
        if power == 1 { return "" }
        if power.denominator != 1 { return "^(\(power))" }
        let digits: [Character: String] = ["0": "⁰", "1": "¹", "2": "²", "3": "³", "4": "⁴", "5": "⁵", "6": "⁶", "7": "⁷", "8": "⁸", "9": "⁹", "-": "⁻"]
        return power.description.map { digit in
            guard let symbol = digits[digit] else { preconditionFailure("Integer spelling contains only a sign and digits") }
            return symbol
        }.joined()
    }
    public func formatted(_ numericalValue: String) -> String? {
        guard let symbol else { return nil }
        if symbol == "1" { return numericalValue }
        return numericalValue + (["°", "′", "″"].contains(symbol) ? "" : " ") + symbol
    }
}

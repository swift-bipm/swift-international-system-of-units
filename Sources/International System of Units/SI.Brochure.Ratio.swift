public import Rational

extension SI.Brochure {
    public enum Ratio: CaseIterable, Hashable, Sendable {
        case percent
        case partsPerMillion
    }
}

extension SI.Brochure.Ratio {
    public var symbol: String { self == .percent ? "%" : "ppm" }

    public var factor: Rational {
        do {
            return try Rational(numerator: 1, denominator: self == .percent ? 100 : 1_000_000)
        } catch {
            preconditionFailure("The fixed definition must be representable and have a nonzero divisor")
        }
    }

    public var source: String { "SI Brochure section 5.4.7; a relative-value notation, not an SI unit or prefix" }
}

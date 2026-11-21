public import Rational

extension BIPM.SI.Brochure {
    public enum Ratio: CaseIterable, Hashable, Sendable {
        case percent
        case partsPerMillion
    }
}

extension BIPM.SI.Brochure.Ratio {
    public var symbol: String { self == .percent ? "%" : "ppm" }

    public var factor: Rational {
        do {
            return try Rational(numerator: 1, denominator: self == .percent ? 100 : 1_000_000)
        } catch {
            preconditionFailure("The fixed definition must be representable and have a nonzero divisor")
        }
    }

    public var source: String { "BIPM.SI Brochure section 5.4.7; a relative-value notation, not an BIPM.SI unit or prefix" }
}

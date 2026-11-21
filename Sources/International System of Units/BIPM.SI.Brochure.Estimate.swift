public import Rational

extension BIPM.SI.Brochure {
    public struct Estimate: Hashable, Sendable {
        public let numericalValue: Rational
        public let standardUncertainty: Rational
        public let unit: BIPM.SI.Unit
        public let source: String
    }
}

extension BIPM.SI.Brochure.Estimate {
    public static var dalton: Self {
        do {
            return Self(
                numericalValue: 166_053_906_892 * (try Rational(10).raised(to: -38)),
                standardUncertainty: 52 * (try Rational(10).raised(to: -38)),
                unit: BIPM.SI.Unit.Name.kilogram.expression,
                source: "CODATA 2022; BIPM.SI Brochure v4.01, Table 8(i)"
            )
        } catch {
            preconditionFailure("The fixed definition must be representable and have a nonzero divisor")
        }
    }
}

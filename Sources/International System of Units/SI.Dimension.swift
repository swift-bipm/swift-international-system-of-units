public import Rational

extension SI {
    public struct Dimension: Hashable, Sendable {
        public let exponents: [Base: Rational]

        public init(_ exponents: [Base: Rational] = [:]) {
            self.exponents = exponents.filter { $0.value != .zero }
        }
        public static let one = Self()
        public subscript(_ base: Base) -> Rational { exponents[base, default: .zero] }
        public static func * (lhs: Self, rhs: Self) -> Self {
            var exponents = lhs.exponents
            for (base, exponent) in rhs.exponents {
                exponents[base] = exponents[base, default: .zero] + exponent
            }
            return Self(exponents)
        }
        public static func / (lhs: Self, rhs: Self) -> Self { lhs * rhs.raised(to: -1) }
        public func raised(to power: Rational) -> Self {
            Self(exponents.mapValues { $0 * power })
        }
        public var symbol: String {
            let factors = Base.allCases.compactMap { base -> String? in
                let exponent = self[base]
                guard exponent != .zero else { return nil }
                return base.symbol + (exponent == .one ? "" : "^(\(exponent))")
            }
            return factors.isEmpty ? "1" : factors.joined(separator: " ")
        }
    }
}

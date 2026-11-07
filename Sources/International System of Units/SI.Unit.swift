public import Rational

extension SI {
    public struct Unit: Hashable, Sendable {
        public let factors: [Factor: Rational]

        internal init(factors: [Factor: Rational]) {
            self.factors = factors.filter { $0.value != 0 }
        }
        public init(_ unit: SI.Unit.Name) { self.init(factors: [Factor(.si(unit)): 1]) }
        public init(_ unit: Brochure.Unit) { self.init(factors: [Factor(.brochure(unit)): 1]) }
    }
}

extension SI.Unit {
    public static let one = Self(factors: [:])

    public var dimension: SI.Dimension {
        factors.reduce(.one) { $0 * $1.key.reference.dimension.raised(to: $1.value) }
    }

    public var isSI: Bool {
        factors.keys.allSatisfy { if case .si = $0.reference { true } else { false } }
    }

    public var isCoherent: Bool {
        guard isSI, !contains(.degreeCelsius) else { return false }
        do { return try conversion(to: coherent).factor.rational == .one } catch { return false }
    }

    public var coherent: Self {
        var result = Self.one
        for base in SI.Base.allCases {
            result *= base.unit.expression.raised(to: dimension[base])
        }
        return result
    }

    public func contains(_ unit: SI.Unit.Name) -> Bool {
        factors.keys.contains { $0.reference == .si(unit) }
    }
}

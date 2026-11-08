public import Rational

extension SI.Brochure {
    public enum Logarithm: Hashable, Sendable {
        case neper
        case bel
        case decibel

        public var unit: Unit {
            switch self {
            case .neper: .neper
            case .bel: .bel
            case .decibel: .decibel
            }
        }
        public var base: String { self == .neper ? "e" : "10" }
        public var multiplier: Rational { self == .decibel ? 10 : 1 }
        public var equation: String {
            switch self {
            case .neper: "LA/Np = ln(A2/A1)"
            case .bel: "LX/B = lg(X/X0)"
            case .decibel: "LX/dB = 10 lg(X/X0)"
            }
        }
        public func conversion(to other: Self) throws(SI.Error) -> SI.Conversion {
            guard base == other.base else { throw .logarithmic }
            do { return .init(try other.multiplier.divided(by: multiplier)) } catch { preconditionFailure("Logarithm multipliers are nonzero") }
        }
    }
}

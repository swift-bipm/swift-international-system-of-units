public import Radical
public import Rational

extension SI {
    public struct Conversion: Equatable, Sendable {
        public let factor: Radical
        public let piExponent: Rational

        internal init(_ coefficient: Rational = .one, piExponent: Rational = 0) {
            self.factor = .init(coefficient)
            self.piExponent = piExponent
        }
        internal init(factor: Radical, piExponent: Rational) {
            self.factor = factor
            self.piExponent = piExponent
        }
    }
}

extension SI.Conversion {
    public func applying(to value: Rational) throws(SI.Error) -> Rational {
        if value == .zero { return .zero }
        guard piExponent == .zero, let coefficient = factor.rational else { throw .irrational }
        return value * coefficient
    }

    public var approximation: Double {
        var base = piExponent < .zero ? 1 / Double.pi : Double.pi
        var count = piExponent.numerator.absolute
        var result = 1.0
        while count != 0 {
            if count.isOdd { result *= base }
            // swift-format-ignore: NeverUseForceTry
            // swiftlint:disable:next force_try
            count = try! count.quotientAndRemainder(dividingBy: 2).quotient
            if count != 0 { base *= base }
        }
        guard let degree = piExponent.denominator.exactly(Int.self) else {
            preconditionFailure("Conversion construction validates the root index")
        }
        return factor.approximation * Radical.root(result, degree: degree)
    }

    internal func multiplied(by other: Self) throws(SI.Error) -> Self {
        do {
            let exponent = piExponent.adding(other.piExponent)
            guard exponent.denominator.exactly(Int.self) != nil else { throw SI.Error.exponent }
            return Self(factor: try factor.multiplied(by: other.factor), piExponent: exponent)
        } catch { throw .exponent }
    }

    internal func raised(to power: Rational) throws(SI.Error) -> Self {
        do {
            let exponent = piExponent.multiplied(by: power)
            guard exponent.denominator.exactly(Int.self) != nil else { throw SI.Error.exponent }
            return Self(factor: try factor.raised(to: power), piExponent: exponent)
        } catch { throw .exponent }
    }
}

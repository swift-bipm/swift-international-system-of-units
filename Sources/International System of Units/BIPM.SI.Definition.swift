public import Rational

extension BIPM.SI {
    public struct Definition: Hashable, Sendable {
        public let constants: [Constant: Int]
        public let steradianExponent: Int

        internal init(_ constants: [Constant: Int], steradianExponent: Int = 0) {
            self.constants = constants
            self.steradianExponent = steradianExponent
        }
    }
}

extension BIPM.SI.Definition {
    public var coefficient: Rational {
        do {
            let product = try constants.reduce(Rational.one) {
                $0 * (try $1.key.numericalValue.raised(to: $1.value))
            }
            return try Rational.one.divided(by: product)
        } catch {
            preconditionFailure("The fixed definition must be representable and have a nonzero divisor")
        }
    }

    public var unit: BIPM.SI.Unit {
        constants.reduce(BIPM.SI.Unit.Name.steradian.expression.raised(to: steradianExponent)) {
            $0 * $1.key.unit.raised(to: $1.value)
        }
    }
}

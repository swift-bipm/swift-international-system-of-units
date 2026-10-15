public import Rational

extension SI {
    public enum Convention {
        public static var gravity: Rational {
            do {
                return try Rational(numerator: 980_665, denominator: 100_000)
            } catch {
                preconditionFailure("The fixed definition must be representable and have a nonzero divisor")
            }
        }
        public static var gravityUnit: SI.Unit {
            SI.Unit.Name.metre.expression / SI.Unit.Name.second.expression.raised(to: 2)
        }
    }
}

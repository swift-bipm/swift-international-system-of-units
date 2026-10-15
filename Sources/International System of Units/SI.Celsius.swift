public import Rational

extension SI {
    public enum Celsius {
        public static var origin: Rational {
            do {
                return try Rational(numerator: 27_315, denominator: 100)
            } catch {
                preconditionFailure("The fixed definition must be representable and have a nonzero divisor")
            }
        }
        public static func fromKelvin(_ value: Rational) -> Rational {
            value - origin
        }
        public static func toKelvin(_ value: Rational) -> Rational {
            value + origin
        }
    }
}

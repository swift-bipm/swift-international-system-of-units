public import Rational

extension BIPM.SI {
    public enum Convention {
    }
}

extension BIPM.SI.Convention {
    public static var gravity: Rational {
        do {
            return try Rational(numerator: 980_665, denominator: 100_000)
        } catch {
            preconditionFailure("The fixed definition must be representable and have a nonzero divisor")
        }
    }

    public static var gravityUnit: BIPM.SI.Unit {
        BIPM.SI.Unit.Name.metre.expression / BIPM.SI.Unit.Name.second.expression.raised(to: 2)
    }
}

import Rational

extension BIPM.SI.Unit {
    public func conversion(to other: Self) throws(BIPM.SI.Error) -> BIPM.SI.Conversion {
        guard dimension == other.dimension else { throw .dimension }
        if contains(.degreeCelsius) || other.contains(.degreeCelsius) { throw .affine }
        return try (self / other).reduction()
    }
    public func intervalConversion(to other: Self) throws(BIPM.SI.Error) -> BIPM.SI.Conversion {
        guard dimension == other.dimension else { throw .dimension }
        return try (self / other).reduction()
    }
    internal func reduction() throws(BIPM.SI.Error) -> BIPM.SI.Conversion {
        var result = BIPM.SI.Conversion()
        for (factor, power) in factors {
            let value: BIPM.SI.Conversion
            switch factor.reference {
            case .si(let unit):
                value = BIPM.SI.Conversion(unit == .gram ? BIPM.SI.Prefix.milli.factor : .one)
            case .brochure(let unit): value = try unit.conversion
            }
            let prefixed = try value.multiplied(by: BIPM.SI.Conversion(factor.prefix?.factor ?? .one))
            result = try result.multiplied(by: prefixed.raised(to: power))
        }
        return result
    }
}

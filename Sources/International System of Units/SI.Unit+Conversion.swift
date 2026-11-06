import Rational

extension SI.Unit {
    public func conversion(to other: Self) throws(SI.Error) -> SI.Conversion {
        guard dimension == other.dimension else { throw .dimension }
        if contains(.degreeCelsius) || other.contains(.degreeCelsius) { throw .affine }
        return try (self / other).reduction()
    }
    public func intervalConversion(to other: Self) throws(SI.Error) -> SI.Conversion {
        guard dimension == other.dimension else { throw .dimension }
        return try (self / other).reduction()
    }
    internal func reduction() throws(SI.Error) -> SI.Conversion {
        var result = SI.Conversion()
        for (factor, power) in factors {
            let value: SI.Conversion
            switch factor.reference {
            case .si(let unit):
                value = SI.Conversion(unit == .gram ? SI.Prefix.milli.factor : .one)
            case .brochure(let unit): value = try unit.conversion
            }
            let prefixed = try value.multiplied(by: SI.Conversion(factor.prefix?.factor ?? .one))
            result = try result.multiplied(by: prefixed.raised(to: power))
        }
        return result
    }
}

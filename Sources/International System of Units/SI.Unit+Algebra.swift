public import Rational

extension SI.Unit {
    public static func * (lhs: Self, rhs: Self) -> Self {
        var factors = lhs.factors
        for (factor, power) in rhs.factors { factors[factor, default: 0] += power }
        return Self(factors: factors)
    }
    public static func / (lhs: Self, rhs: Self) -> Self { lhs * rhs.raised(to: -1) }
    public func raised(to power: Int) -> Self { raised(to: Rational(Int128(power))) }
    public func raised(to power: Rational) -> Self { Self(factors: factors.mapValues { $0 * power }) }

    public func prefixed(_ prefix: SI.Prefix) throws(SI.Error) -> Self {
        guard factors.count == 1, let (factor, power) = factors.first,
            power == 1, factor.prefix == nil
        else { throw .prefix }
        switch factor.reference {
        case .si(.kilogram): throw .prefix
        case .si(.gram) where prefix == .kilo: return Self(.kilogram)
        case .si: break
        case .brochure(let unit):
            guard unit.permitsPrefix else { throw .prefix }
            if unit == .arcsecond && factor.spelling != "as" { throw .prefix }
        }
        return Self(factors: [Factor(factor.reference, prefix: prefix, spelling: factor.spelling): 1])
    }
    public func spelled(_ symbol: String) throws(SI.Error) -> Self {
        guard factors.count == 1, let (factor, power) = factors.first,
            power == 1, factor.reference.symbols.contains(symbol)
        else { throw .syntax }
        return Self(factors: [Factor(factor.reference, prefix: factor.prefix, spelling: symbol): 1])
    }
}

extension SI.Unit {
    public func multiplied(by other: Self) throws(SI.Error) -> Self {
        var factors = self.factors
        do {
            for (factor, exponent) in other.factors {
                factors[factor] = try factors[factor, default: 0].adding(exponent)
            }
        } catch { throw .exponent }
        return Self(factors: factors)
    }
    public func power(_ exponent: Rational) throws(SI.Error) -> Self {
        var factors: [Factor: Rational] = [:]
        do {
            for (factor, power) in self.factors {
                factors[factor] = try power.multiplied(by: exponent)
            }
        } catch { throw .exponent }
        return Self(factors: factors)
    }
    public static func *= (lhs: inout Self, rhs: Self) { lhs = lhs * rhs }
}

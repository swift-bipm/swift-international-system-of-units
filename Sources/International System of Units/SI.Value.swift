public import Rational

extension SI {
    public struct Value: Hashable, Sendable {
        public let numericalValue: Rational
        public let quantity: Quantity
        public let unit: Unit

        public init(_ numericalValue: Rational, quantity: Quantity, unit: Unit? = nil) throws(Error) {
            let unit = unit ?? quantity.unit
            guard quantity.accepts(unit) else { throw .quantity }
            self.numericalValue = numericalValue
            self.quantity = quantity
            self.unit = unit
        }
    }
}

extension SI.Value {
    public func converted(to unit: Unit) throws(Error) -> Self {
        guard quantity.accepts(unit) else { throw .quantity }
        let conversion =
            quantity == .temperatureInterval
            ? try self.unit.intervalConversion(to: unit) : try self.unit.conversion(to: unit)
        return try Self(conversion.applying(to: numericalValue), quantity: quantity, unit: unit)
    }

    public func approximation(in unit: Unit) throws(Error) -> Double {
        guard quantity.accepts(unit) else { throw .quantity }
        let conversion =
            quantity == .temperatureInterval
            ? try self.unit.intervalConversion(to: unit) : try self.unit.conversion(to: unit)
        return numericalValue.approximation * conversion.approximation
    }

    public func adding(_ other: Self) throws(Error) -> Self {
        guard quantity == other.quantity else { throw .quantity }
        guard quantity != .celsiusTemperature && quantity != .thermodynamicTemperature else { throw .affine }
        let converted = try other.converted(to: unit)
        return try Self(numericalValue + converted.numericalValue, quantity: quantity, unit: unit)
    }

    public func subtracting(_ other: Self) throws(Error) -> Self {
        guard quantity == other.quantity else { throw .quantity }
        if quantity == .celsiusTemperature || quantity == .thermodynamicTemperature {
            guard self.unit == other.unit else { throw .affine }
            return try Self(numericalValue - other.numericalValue, quantity: .temperatureInterval, unit: unit)
        }
        let converted = try other.converted(to: unit)
        return try Self(numericalValue - converted.numericalValue, quantity: quantity, unit: unit)
    }

    public func multiplied(by other: Value, as quantity: Quantity) throws(Error) -> Self {
        guard self.quantity != .celsiusTemperature, other.quantity != .celsiusTemperature else { throw .affine }
        return try Self(numericalValue * other.numericalValue, quantity: quantity, unit: unit * other.unit)
    }

    public func divided(by other: Value, as quantity: Quantity) throws(Error) -> Self {
        guard self.quantity != .celsiusTemperature, other.quantity != .celsiusTemperature else { throw .affine }
        let value: Rational
        do { value = try numericalValue.divided(by: other.numericalValue) } catch { throw .zero }
        return try Self(value, quantity: quantity, unit: unit / other.unit)
    }
}

internal import Rational

extension SI {
    public struct Quantity: Hashable, Sendable {
        public let name: String
        public let unit: Unit

        public init(name: String, unit: Unit) {
            self.name = name
            self.unit = unit
        }
        public var dimension: SI.Dimension { unit.dimension }

        public func accepts(_ expression: Unit) -> Bool {
            guard dimension == expression.dimension else { return false }
            if self == .planeAngle || self == .phaseAngle {
                return expression.angular == (1, 0)
            }
            if self == .solidAngle { return expression.angular == (0, 1) }
            if self == .frequency && (expression.contains(.becquerel) || expression.angular != (0, 0)) { return false }
            if self == .activity && (expression.contains(.hertz) || expression.angular != (0, 0)) { return false }
            if self == .torque && expression.contains(.joule) { return false }
            if (self == .absorbedDose || self == .kerma) && expression.contains(.sievert) { return false }
            if self == .doseEquivalent && expression.contains(.gray) { return false }
            if self == .entityCount && expression.angular != (0, 0) { return false }
            if self == .angularVelocity || self == .angularFrequency || self == .angularAcceleration {
                return expression.angular == (1, 0) && !expression.contains(.hertz) && !expression.contains(.becquerel)
            }
            if self == .thermodynamicTemperature && expression.contains(.degreeCelsius) { return false }
            if self == .celsiusTemperature { return expression == SI.Unit.Name.degreeCelsius.expression }
            return true
        }
    }
}

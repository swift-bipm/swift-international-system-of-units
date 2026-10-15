internal import Rational

extension SI.Value {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        guard lhs.quantity == rhs.quantity else { return false }
        do {
        let left = try lhs.unit.reduction()
        let right = try rhs.unit.reduction()
        let leftValue = left.factor.scaled(by: lhs.numericalValue)
        let rightValue = right.factor.scaled(by: rhs.numericalValue)
        if leftValue.rational == .zero && rightValue.rational == .zero { return true }
        return leftValue == rightValue && left.piExponent == right.piExponent
        } catch {
            return lhs.unit == rhs.unit && lhs.numericalValue == rhs.numericalValue
        }
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(quantity)
        do {
            let conversion = try unit.reduction()
            let value = conversion.factor.scaled(by: numericalValue)
            hasher.combine(true)
            hasher.combine(value)
            hasher.combine(value.rational == .zero ? Rational.zero : conversion.piExponent)
        } catch {
            hasher.combine(false)
            hasher.combine(numericalValue)
            hasher.combine(unit)
        }
    }
}

import International_System_of_Units
import Rational
import Testing

@Suite struct `Normalization and definitions` {
    @Test func `base units follow from the seven constants without rounded inversions`() throws {
        for base in SI.Base.allCases {
            let definition = base.definition
            let value = try definition.constants.reduce(Rational.one) {
                $0 * (try $1.key.numericalValue.raised(to: $1.value))
            }
            #expect(definition.coefficient * value == 1)
            #expect(definition.unit.dimension == base.unit.dimension)
            #expect(try definition.unit.conversion(to: base.unit.expression).factor.radicand == 1)
        }
        #expect(SI.Base.luminousIntensity.definition.unit.angular.solid == 0)
        #expect(SI.Convention.gravity * 100000 == 980665)
    }
    @Test func `unit symbol parsing round trips the complete named catalogues`() throws {
        for unit in SI.Unit.Name.allCases {
            #expect(try SI.Unit(symbol: unit.symbol, scope: .si) == unit.expression)
        }
        for unit in SI.Brochure.Unit.allCases {
            for symbol in unit.symbols {
                let parsed = try SI.Unit(symbol: symbol, scope: .brochure)
                #expect(parsed.symbol == symbol)
                #expect(!parsed.isSI)
            }
        }
        for prefix in SI.Prefix.allCases {
            for unit in SI.Unit.Name.allCases where unit != .kilogram {
                let expression = try unit.prefixed(prefix)
                let symbol = try #require(expression.symbol)
                #expect(try SI.Unit(symbol: symbol, scope: .si) == expression)
            }
        }
        let expression = SI.Unit.Name.kilogram.expression * SI.Unit.Name.metre.expression.raised(to: 2) / SI.Unit.Name.second.expression.raised(to: 3)
        #expect(try SI.Unit(symbol: "kg m^2/s^3") == expression)
        #expect(try SI.Unit(symbol: "kg⋅m²⋅s⁻³") == expression)
        #expect(try SI.Unit(symbol: "kg m²/(s s²)") == expression)
        #expect(try SI.Unit(symbol: "(m/s)^2").symbol == "m²⋅s⁻²")
        #expect(try SI.Unit.Name.gram.prefixed(.kilo) == SI.Unit.Name.kilogram.expression)
        #expect(try SI.Unit(symbol: "mas").symbol == "mas")
        #expect(throws: SI.Error.ambiguous) { try SI.Unit(symbol: "as") }
        #expect(try SI.Unit(symbol: "as", scope: .si).dimension == SI.Quantity.time.dimension)
        #expect(try SI.Unit(symbol: "as", scope: .brochure).dimension == .one)
    }
    @Test func `invalid symbols and ambiguous solidus expressions are rejected`() {
        for text in ["", "sec", "mps", "Nm", "k1", "µkg", "mkg", "m/s/kg", "m//s", "m/", "(m/s", "m)", "m^", "m⁻", "m..s"] {
            #expect(throws: (any Swift.Error).self) { try SI.Unit(symbol: text) }
        }
        #expect(throws: SI.Error.syntax) { try SI.Notation.decimal(".5") }
        #expect(throws: SI.Error.syntax) { try SI.Notation.decimal("+") }
        #expect(throws: SI.Error.syntax) { try SI.Notation.decimal("1,234.5") }
    }
    @Test func `unit exponents preserve arbitrary precision`() throws {
        let power: Rational = 999999999999999999999999999999999999999999999999999
        let unit = SI.Unit.Name.metre.expression.raised(to: power)
        #expect(try SI.Unit(symbol: "m^" + power.description) == unit)
        #expect(try SI.Unit(symbol: #require(unit.symbol)) == unit)
        #expect(try SI.Unit(symbol: "(m^340282366920938463463374607431768211455)^2") == SI.Unit.Name.metre.expression.raised(to: Rational(UInt128.max) * 2))
    }
    @Test func `equal quantity values hash alike across unit representations`() throws {
        let metre = SI.Unit.Name.metre.expression
        let centimetre = try metre.prefixed(.centi)
        let a = try SI.Value(2, quantity: .length, unit: metre)
        let b = try SI.Value(200, quantity: .length, unit: centimetre)
        #expect(a == b)
        #expect(Set([a, b]).count == 1)
        #expect(try b.converted(to: metre).converted(to: centimetre) == b)
        let zeroRadians = try SI.Value(0, quantity: .planeAngle)
        let zeroDegrees = try SI.Value(0, quantity: .planeAngle, unit: SI.Brochure.Unit.degree.expression)
        #expect(zeroRadians == zeroDegrees)
        #expect(Set([zeroRadians, zeroDegrees]).count == 1)
        #expect(try zeroDegrees.converted(to: SI.Unit.Name.radian.expression) == zeroRadians)
    }
}

import Radical
import International_System_of_Units
import Rational
import Testing

enum `BIPM.SI.Normalization Tests` {}

extension `BIPM.SI.Normalization Tests` {
    @Suite struct `Normalization and definitions` {
        @Test func `base units follow from the seven constants without rounded inversions`() throws {
            for base in BIPM.SI.Base.allCases {
                let definition = base.definition
                let value = try definition.constants.reduce(Rational.one) {
                    $0 * (try $1.key.numericalValue.raised(to: $1.value))
                }
                #expect(definition.coefficient * value == 1)
                #expect(definition.unit.dimension == base.unit.dimension)
                #expect(try definition.unit.conversion(to: base.unit.expression).factor.radicand == 1)
            }
            #expect(BIPM.SI.Base.luminousIntensity.definition.unit.angular.solid == 0)
            #expect(BIPM.SI.Convention.gravity * 100000 == 980665)
        }
        @Test func `unit symbol parsing round trips the complete named catalogues`() throws {
            for unit in BIPM.SI.Unit.Name.allCases {
                #expect(try BIPM.SI.Unit(symbol: unit.symbol, scope: .si) == unit.expression)
            }
            for unit in BIPM.SI.Brochure.Unit.allCases {
                for symbol in unit.symbols {
                    let parsed = try BIPM.SI.Unit(symbol: symbol, scope: .brochure)
                    #expect(parsed.symbol == symbol)
                    #expect(!parsed.isSI)
                }
            }
            for prefix in BIPM.SI.Prefix.allCases {
                for unit in BIPM.SI.Unit.Name.allCases where unit != .kilogram {
                    let expression = try unit.prefixed(prefix)
                    let symbol = try #require(expression.symbol)
                    #expect(try BIPM.SI.Unit(symbol: symbol, scope: .si) == expression)
                }
            }
            let expression = BIPM.SI.Unit.Name.kilogram.expression * BIPM.SI.Unit.Name.metre.expression.raised(to: 2) / BIPM.SI.Unit.Name.second.expression.raised(to: 3)
            #expect(try BIPM.SI.Unit(symbol: "kg m^2/s^3") == expression)
            #expect(try BIPM.SI.Unit(symbol: "kg⋅m²⋅s⁻³") == expression)
            #expect(try BIPM.SI.Unit(symbol: "kg m²/(s s²)") == expression)
            #expect(try BIPM.SI.Unit(symbol: "(m/s)^2").symbol == "m²⋅s⁻²")
            #expect(try BIPM.SI.Unit.Name.gram.prefixed(.kilo) == BIPM.SI.Unit.Name.kilogram.expression)
            #expect(try BIPM.SI.Unit(symbol: "mas").symbol == "mas")
            #expect(throws: BIPM.SI.Error.ambiguous) { try BIPM.SI.Unit(symbol: "as") }
            #expect(try BIPM.SI.Unit(symbol: "as", scope: .si).dimension == BIPM.SI.Quantity.time.dimension)
            #expect(try BIPM.SI.Unit(symbol: "as", scope: .brochure).dimension == .one)
        }
        @Test func `invalid symbols and ambiguous solidus expressions are rejected`() {
            for text in ["", "sec", "mps", "Nm", "k1", "µkg", "mkg", "m/s/kg", "m//s", "m/", "(m/s", "m)", "m^", "m⁻", "m..s"] {
                #expect(throws: (any Swift.Error).self) { try BIPM.SI.Unit(symbol: text) }
            }
            #expect(throws: BIPM.SI.Error.syntax) { try BIPM.SI.Notation.decimal(".5") }
            #expect(throws: BIPM.SI.Error.syntax) { try BIPM.SI.Notation.decimal("+") }
            #expect(throws: BIPM.SI.Error.syntax) { try BIPM.SI.Notation.decimal("1,234.5") }
        }
        @Test func `unit exponents preserve arbitrary precision`() throws {
            let power: Rational = 999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999
            let unit = BIPM.SI.Unit.Name.metre.expression.raised(to: power)
            #expect(try BIPM.SI.Unit(symbol: "m^" + power.description) == unit)
            #expect(try BIPM.SI.Unit(symbol: #require(unit.symbol)) == unit)
            #expect(try BIPM.SI.Unit(symbol: "(m^340282366920938463463374607431768211455)^2") == BIPM.SI.Unit.Name.metre.expression.raised(to: Rational(UInt128.max) * 2))
        }
        @Test func `equal quantity values hash alike across unit representations`() throws {
            let metre = BIPM.SI.Unit.Name.metre.expression
            let centimetre = try metre.prefixed(.centi)
            let a = try BIPM.SI.Value(2, quantity: .length, unit: metre)
            let b = try BIPM.SI.Value(200, quantity: .length, unit: centimetre)
            #expect(a == b)
            #expect(Set([a, b]).count == 1)
            #expect(try b.converted(to: metre).converted(to: centimetre) == b)
            let zeroRadians = try BIPM.SI.Value(0, quantity: .planeAngle)
            let zeroDegrees = try BIPM.SI.Value(0, quantity: .planeAngle, unit: BIPM.SI.Brochure.Unit.degree.expression)
            #expect(zeroRadians == zeroDegrees)
            #expect(Set([zeroRadians, zeroDegrees]).count == 1)
            #expect(try zeroDegrees.converted(to: BIPM.SI.Unit.Name.radian.expression) == zeroRadians)
        }
    }
}

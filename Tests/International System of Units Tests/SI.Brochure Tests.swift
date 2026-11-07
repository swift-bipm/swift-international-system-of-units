import International_System_of_Units
import Rational
import Testing

enum `SI.Brochure Tests` {}

extension `SI.Brochure Tests` {
    @Suite struct `Brochure references` {
        @Test func `table eight contains all twenty three non SI entries`() {
            #expect(SI.Brochure.Unit.table8.count == 23)
            #expect(SI.Brochure.Unit.table8.allSatisfy { !$0.expression.isSI })
            #expect(SI.Brochure.Unit.table8.filter { $0.category == .longStanding }.count == 6)
            #expect(SI.Brochure.Unit.table8.filter { $0.category == .decimal }.count == 8)
            #expect(SI.Brochure.Unit.table8.filter { $0.category == .international }.count == 5)
            #expect(SI.Brochure.Unit.table8.filter { $0.category == .technical }.count == 4)
            #expect(SI.Brochure.Unit.degree.admission == nil)
            #expect(SI.Brochure.Unit.litre.admission != nil)
            #expect(SI.Brochure.Unit.nauticalMile.symbols.isEmpty)
            #expect(SI.Brochure.Unit.knot.symbols.isEmpty)
            #expect(SI.Brochure.Unit.dalton.symbols == ["Da", "u"])
        }

        @Test func `all rational reference conversions retain exact definitions`() throws {
            let values: [(SI.Brochure.Unit, Rational)] = [
                (.minute, 60), (.hour, 3600), (.day, 86400), (.are, 100), (.hectare, 10000),
                (.barn, try Rational(10).raised(to: -28)),
                (.litre, try Rational(1).divided(by: 1000)), (.tonne, 1000),
                (.angstrom, try Rational(10).raised(to: -10)),
                (.gal, try Rational(1).divided(by: 100)), (.bar, 100000),
                (.astronomicalUnit, 149_597_870_700), (.nauticalMile, 1852),
                (.knot, try Rational(1852).divided(by: 3600)),
                (.electronvolt, SI.Constant.elementaryCharge.numericalValue), (.var, 1),
                (.atmosphere, 101325), (.curie, 37_000_000_000),
                (.enzymeUnit, try Rational(1).divided(by: 60_000_000)),
            ]
            for (unit, expected) in values {
                #expect(try unit.conversion.factor.radicand == expected)
                #expect(try unit.conversion.piExponent == 0)
                #expect(try unit.expression.conversion(to: unit.expression.coherent).factor.radicand == expected)
            }
            let degree = SI.Brochure.Unit.degree.expression
            let minute = SI.Brochure.Unit.arcminute.expression
            let second = SI.Brochure.Unit.arcsecond.expression
            #expect(try degree.conversion(to: minute).applying(to: 1) == 60)
            #expect(try minute.conversion(to: second).applying(to: 1) == 60)
            #expect(try degree.conversion(to: second).applying(to: 1) == 3600)
            #expect(try SI.Brochure.Unit.arcsecond.conversion.factor.radicand * 648000 == 1)
        }

        @Test func `experimental dalton is never an exact SI scale`() throws {
            #expect(throws: SI.Error.experimental) { try SI.Brochure.Unit.dalton.conversion }
            let estimate = SI.Brochure.Estimate.dalton
            let scale = try Rational(10).raised(to: 38)
            #expect(estimate.numericalValue * scale == 166_053_906_892)
            #expect(estimate.standardUncertainty * scale == 52)
            #expect(estimate.source.contains("2022"))
            #expect(try SI.Brochure.Unit.dalton.expression.conversion(to: SI.Brochure.Unit.dalton.expression).factor.radicand == 1)
        }

        @Test func `logarithmic ratios require their quantity and reference convention`() throws {
            #expect(throws: SI.Error.logarithmic) { try SI.Brochure.Unit.decibel.conversion }
            #expect(try SI.Brochure.Logarithm.decibel.conversion(to: .bel).applying(to: 10) == 1)
            #expect(throws: SI.Error.logarithmic) { try SI.Brochure.Logarithm.neper.conversion(to: .decibel) }
            #expect(SI.Brochure.Logarithm.neper.equation == "LA/Np = ln(A2/A1)")
            #expect(SI.Brochure.Ratio.percent.factor * 100 == 1)
            #expect(SI.Brochure.Ratio.partsPerMillion.factor * 1_000_000 == 1)
        }

        @Test func `symbols follow spacing powers and alternative spelling rules`() throws {
            #expect(SI.Unit.Name.degreeCelsius.expression.formatted("30.2") == "30.2 °C")
            #expect(SI.Brochure.Unit.degree.expression.formatted("30") == "30°")
            #expect(SI.Brochure.Unit.arcminute.expression.formatted("22") == "22′")
            #expect(SI.Unit.one.formatted("1.51") == "1.51")
            #expect(SI.Unit.Name.metre.expression.raised(to: -2).symbol == "m⁻²")
            #expect(try SI.Brochure.Unit.litre.expression.spelled("L").symbol == "L")
            #expect(SI.Brochure.Unit.nauticalMile.expression.symbol == nil)
            #expect(throws: SI.Error.syntax) { try SI.Unit.Name.second.expression.spelled("sec") }
        }
    }
}

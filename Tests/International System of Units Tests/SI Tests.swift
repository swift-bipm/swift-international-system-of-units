import Radical
import International_System_of_Units
import Rational
import Testing

enum `BIPM.SI Tests` {}

extension `BIPM.SI Tests` {
    @Suite struct `BIPM.SI specification` {
        @Test func `seven defining values are exact in their prescribed units`() throws {
            let constants = BIPM.SI.Constant.allCases
            #expect(constants.count == 7)
            let ten = Rational(10)
            #expect(BIPM.SI.Constant.caesiumFrequency.numericalValue == 9_192_631_770)
            #expect(BIPM.SI.Constant.speedOfLight.numericalValue == 299_792_458)
            #expect(BIPM.SI.Constant.planck.numericalValue * (try ten.raised(to: 42)) == 662_607_015)
            #expect(BIPM.SI.Constant.elementaryCharge.numericalValue * (try ten.raised(to: 28)) == 1_602_176_634)
            #expect(BIPM.SI.Constant.boltzmann.numericalValue * (try ten.raised(to: 29)) == 1_380_649)
            #expect(BIPM.SI.Constant.avogadro.numericalValue == 602_214_076_000_000_000_000_000)
            #expect(BIPM.SI.Constant.luminousEfficacy.numericalValue == 683)
            #expect(BIPM.SI.Constant.photometricFrequency == 540_000_000_000_000)
            #expect(constants.allSatisfy { $0.unit.isSI && $0.unit.isCoherent })
            #expect(BIPM.SI.Constant.planck.unit.dimension == .init([.mass: 1, .length: 2, .time: -1]))
            #expect(BIPM.SI.Constant.boltzmann.unit.dimension == .init([.mass: 1, .length: 2, .time: -2, .thermodynamicTemperature: -1]))
        }

        @Test func `all twenty four decimal prefixes match table seven`() throws {
            let expected: [(String, String, Int)] = [
                ("quetta", "Q", 30), ("ronna", "R", 27), ("yotta", "Y", 24), ("zetta", "Z", 21),
                ("exa", "E", 18), ("peta", "P", 15), ("tera", "T", 12), ("giga", "G", 9),
                ("mega", "M", 6), ("kilo", "k", 3), ("hecto", "h", 2), ("deca", "da", 1),
                ("deci", "d", -1), ("centi", "c", -2), ("milli", "m", -3), ("micro", "µ", -6),
                ("nano", "n", -9), ("pico", "p", -12), ("femto", "f", -15), ("atto", "a", -18),
                ("zepto", "z", -21), ("yocto", "y", -24), ("ronto", "r", -27), ("quecto", "q", -30),
            ]
            #expect(BIPM.SI.Prefix.allCases.count == expected.count)
            for (name, symbol, exponent) in expected {
                let prefix = try #require(BIPM.SI.Prefix(rawValue: exponent))
                #expect(prefix.name == name)
                #expect(prefix.symbol == symbol)
                #expect(prefix.factor * (try Rational(10).raised(to: -exponent)) == 1)
            }
            #expect(BIPM.SI.Prefix.kilo.factor == 1000)
        }

        @Test func `all base and special named units match tables two and four`() throws {
            let unit = BIPM.SI.Unit.Name.self
            #expect(unit.base.count == 7)
            #expect(unit.special.count == 22)
            #expect(Set(unit.base.map(\.symbol)) == Set(["s", "m", "kg", "A", "K", "mol", "cd"]))
            let expected: [(BIPM.SI.Unit.Name, String, [Int])] = [
                (.radian, "rad", [0, 0, 0, 0, 0, 0, 0]), (.steradian, "sr", [0, 0, 0, 0, 0, 0, 0]),
                (.hertz, "Hz", [-1, 0, 0, 0, 0, 0, 0]), (.newton, "N", [-2, 1, 1, 0, 0, 0, 0]),
                (.pascal, "Pa", [-2, -1, 1, 0, 0, 0, 0]), (.joule, "J", [-2, 2, 1, 0, 0, 0, 0]),
                (.watt, "W", [-3, 2, 1, 0, 0, 0, 0]), (.coulomb, "C", [1, 0, 0, 1, 0, 0, 0]),
                (.volt, "V", [-3, 2, 1, -1, 0, 0, 0]), (.farad, "F", [4, -2, -1, 2, 0, 0, 0]),
                (.ohm, "Ω", [-3, 2, 1, -2, 0, 0, 0]), (.siemens, "S", [3, -2, -1, 2, 0, 0, 0]),
                (.weber, "Wb", [-2, 2, 1, -1, 0, 0, 0]), (.tesla, "T", [-2, 0, 1, -1, 0, 0, 0]),
                (.henry, "H", [-2, 2, 1, -2, 0, 0, 0]), (.degreeCelsius, "°C", [0, 0, 0, 0, 1, 0, 0]),
                (.lumen, "lm", [0, 0, 0, 0, 0, 0, 1]), (.lux, "lx", [0, -2, 0, 0, 0, 0, 1]),
                (.becquerel, "Bq", [-1, 0, 0, 0, 0, 0, 0]), (.gray, "Gy", [-2, 2, 0, 0, 0, 0, 0]),
                (.sievert, "Sv", [-2, 2, 0, 0, 0, 0, 0]), (.katal, "kat", [-1, 0, 0, 0, 0, 1, 0]),
            ]
            #expect(Set(expected.map { $0.0 }) == Set(unit.special))
            for (named, symbol, exponents) in expected {
                #expect(named.symbol == symbol)
                #expect(BIPM.SI.Base.allCases.map { named.dimension[$0] } == exponents.map { Rational(Int128($0)) })
                #expect(try named.expression.intervalConversion(to: named.expression.coherent).factor.radicand == 1)
            }
        }

        @Test func `derived units satisfy coherent physical relationships`() throws {
            let metre = BIPM.SI.Unit.Name.metre.expression
            let second = BIPM.SI.Unit.Name.second.expression
            let newton = BIPM.SI.Unit.Name.newton.expression
            let joule = BIPM.SI.Unit.Name.joule.expression
            let watt = BIPM.SI.Unit.Name.watt.expression
            let ampere = BIPM.SI.Unit.Name.ampere.expression
            let volt = BIPM.SI.Unit.Name.volt.expression
            let pairs: [(BIPM.SI.Unit.Name, BIPM.SI.Unit)] = [
                (.newton, BIPM.SI.Unit.Name.kilogram.expression * metre / second.raised(to: 2)),
                (.pascal, newton / metre.raised(to: 2)), (.joule, newton * metre), (.watt, joule / second),
                (.coulomb, ampere * second), (.volt, watt / ampere),
                (.farad, BIPM.SI.Unit.Name.coulomb.expression / volt), (.ohm, volt / ampere),
                (.siemens, ampere / volt), (.weber, volt * second),
                (.tesla, BIPM.SI.Unit.Name.weber.expression / metre.raised(to: 2)),
                (.henry, BIPM.SI.Unit.Name.weber.expression / ampere),
                (.lumen, BIPM.SI.Unit.Name.candela.expression * BIPM.SI.Unit.Name.steradian.expression),
                (.lux, BIPM.SI.Unit.Name.lumen.expression / metre.raised(to: 2)),
                (.gray, joule / BIPM.SI.Unit.Name.kilogram.expression),
                (.sievert, joule / BIPM.SI.Unit.Name.kilogram.expression),
                (.katal, BIPM.SI.Unit.Name.mole.expression / second),
            ]
            for (name, expression) in pairs {
                #expect(try name.expression.conversion(to: expression).factor.radicand == 1)
                #expect(expression.isCoherent)
            }
            #expect(metre * second == second * metre)
            #expect((metre / second) * second == metre)
            #expect((metre * second).raised(to: 3) == metre.raised(to: 3) * second.raised(to: 3))
            #expect(metre.raised(to: 0) == .one)
        }

        @Test func `radian and steradian keep angular roles without new BIPM.SI dimensions`() throws {
            let radian = BIPM.SI.Unit.Name.radian.expression
            let steradian = BIPM.SI.Unit.Name.steradian.expression
            #expect(radian.dimension == .one)
            #expect(steradian.dimension == .one)
            #expect(radian != steradian && radian != .one)
            #expect(BIPM.SI.Quantity.planeAngle.accepts(radian))
            #expect(!BIPM.SI.Quantity.planeAngle.accepts(.one))
            #expect(!BIPM.SI.Quantity.planeAngle.accepts(steradian))
            #expect(BIPM.SI.Quantity.solidAngle.accepts(steradian))
            let degree = BIPM.SI.Brochure.Unit.degree.expression
            #expect(!degree.isSI)
            #expect(BIPM.SI.Quantity.planeAngle.accepts(degree))
            let conversion = try degree.conversion(to: radian)
            #expect(conversion.piExponent == 1)
            #expect(conversion.factor.radicand * 180 == 1)
            #expect(try (degree.raised(to: 2)).conversion(to: radian.raised(to: 2)).piExponent == 2)
            #expect(throws: BIPM.SI.Error.irrational) { try conversion.applying(to: 180) }
            #expect(abs(conversion.approximation * 180 - Double.pi) < 1e-14)
        }

        @Test func `prefixes are inseparable and kilogram prefixes attach to gram`() throws {
            let metre = BIPM.SI.Unit.Name.metre.expression
            let centimetre = try metre.prefixed(.centi)
            #expect(try centimetre.raised(to: 3).conversion(to: metre.raised(to: 3)).factor.radicand == BIPM.SI.Prefix.micro.factor)
            #expect(try centimetre.raised(to: -1).conversion(to: metre.raised(to: -1)).factor.radicand == 100)
            let milligram = try BIPM.SI.Unit.Name.gram.prefixed(.milli)
            #expect(milligram.symbol == "mg")
            #expect(try milligram.conversion(to: BIPM.SI.Unit.Name.kilogram.expression).factor.radicand == BIPM.SI.Prefix.micro.factor)
            #expect(throws: BIPM.SI.Error.prefix) { try BIPM.SI.Unit.Name.kilogram.prefixed(.micro) }
            #expect(throws: BIPM.SI.Error.prefix) { try centimetre.prefixed(.milli) }
            #expect(throws: BIPM.SI.Error.prefix) { try BIPM.SI.Unit.one.prefixed(.kilo) }
            #expect(throws: BIPM.SI.Error.prefix) { try metre.raised(to: 2).prefixed(.centi) }
            #expect(!centimetre.isCoherent)
            #expect(BIPM.SI.Unit.Name.kilogram.expression.isCoherent)
        }

        @Test func `Celsius coordinates and intervals have distinct laws`() throws {
            #expect(try BIPM.SI.Celsius.toKelvin(0) == Rational(numerator: 27315, denominator: 100))
            for value: Rational in [-100, 0, 37, 100] {
                #expect(BIPM.SI.Celsius.fromKelvin(BIPM.SI.Celsius.toKelvin(value)) == value)
            }
            let celsius = BIPM.SI.Unit.Name.degreeCelsius.expression
            let kelvin = BIPM.SI.Unit.Name.kelvin.expression
            #expect(throws: BIPM.SI.Error.affine) { try celsius.conversion(to: kelvin) }
            #expect(try celsius.intervalConversion(to: kelvin).applying(to: 10) == 10)
            #expect(!celsius.isCoherent)
            let interval = try BIPM.SI.Value(10, quantity: .temperatureInterval, unit: celsius)
            #expect(try interval.converted(to: kelvin).numericalValue == 10)
        }

        @Test func `quantity descriptors reject dimensionally equal semantic substitutions`() throws {
            #expect(!BIPM.SI.Quantity.frequency.accepts(BIPM.SI.Unit.Name.becquerel.expression))
            #expect(!BIPM.SI.Quantity.activity.accepts(BIPM.SI.Unit.Name.hertz.expression))
            #expect(!BIPM.SI.Quantity.torque.accepts(BIPM.SI.Unit.Name.joule.expression))
            #expect(!BIPM.SI.Quantity.absorbedDose.accepts(BIPM.SI.Unit.Name.sievert.expression))
            #expect(!BIPM.SI.Quantity.doseEquivalent.accepts(BIPM.SI.Unit.Name.gray.expression))
            for quantity in BIPM.SI.Quantity.brochure { #expect(quantity.accepts(quantity.unit)) }
            let energy = try BIPM.SI.Value(2, quantity: .energy)
            let torque = try BIPM.SI.Value(2, quantity: .torque)
            #expect(throws: BIPM.SI.Error.quantity) { try energy.adding(torque) }
            let kilometre = try BIPM.SI.Unit.Name.metre.prefixed(.kilo)
            let distance = try BIPM.SI.Value(3, quantity: .length, unit: kilometre)
            let metres = try BIPM.SI.Value(20, quantity: .length)
            #expect(try distance.adding(metres).converted(to: BIPM.SI.Unit.Name.metre.expression).numericalValue == 3020)
            let duration = try BIPM.SI.Value(2, quantity: .time)
            #expect(try distance.divided(by: duration, as: .speed).converted(to: BIPM.SI.Quantity.speed.unit).numericalValue == 1500)
        }
    }
}

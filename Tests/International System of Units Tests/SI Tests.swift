import International_System_of_Units
import Rational
import Testing

@Suite struct `SI specification` {
    @Test func `seven defining values are exact in their prescribed units`() throws {
        let constants = SI.Constant.allCases
        #expect(constants.count == 7)
        let ten = Rational(10)
        #expect(SI.Constant.caesiumFrequency.numericalValue == 9_192_631_770)
        #expect(SI.Constant.speedOfLight.numericalValue == 299_792_458)
        #expect(SI.Constant.planck.numericalValue * (try ten.raised(to: 42)) == 662_607_015)
        #expect(SI.Constant.elementaryCharge.numericalValue * (try ten.raised(to: 28)) == 1_602_176_634)
        #expect(SI.Constant.boltzmann.numericalValue * (try ten.raised(to: 29)) == 1_380_649)
        #expect(SI.Constant.avogadro.numericalValue == 602_214_076_000_000_000_000_000)
        #expect(SI.Constant.luminousEfficacy.numericalValue == 683)
        #expect(SI.Constant.photometricFrequency == 540_000_000_000_000)
        #expect(constants.allSatisfy { $0.unit.isSI && $0.unit.isCoherent })
        #expect(SI.Constant.planck.unit.dimension == .init([.mass: 1, .length: 2, .time: -1]))
        #expect(SI.Constant.boltzmann.unit.dimension == .init([.mass: 1, .length: 2, .time: -2, .thermodynamicTemperature: -1]))
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
        #expect(SI.Prefix.allCases.count == expected.count)
        for (name, symbol, exponent) in expected {
            let prefix = try #require(SI.Prefix(rawValue: exponent))
            #expect(prefix.name == name)
            #expect(prefix.symbol == symbol)
            #expect(prefix.factor * (try Rational(10).raised(to: -exponent)) == 1)
        }
        #expect(SI.Prefix.kilo.factor == 1000)
    }

    @Test func `all base and special named units match tables two and four`() throws {
        let unit = SI.Unit.Name.self
        #expect(unit.base.count == 7)
        #expect(unit.special.count == 22)
        #expect(Set(unit.base.map(\.symbol)) == Set(["s", "m", "kg", "A", "K", "mol", "cd"]))
        let expected: [(SI.Unit.Name, String, [Int])] = [
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
            #expect(SI.Base.allCases.map { named.dimension[$0] } == exponents.map { Rational(Int128($0)) })
            #expect(try named.expression.intervalConversion(to: named.expression.coherent).factor.radicand == 1)
        }
    }

    @Test func `derived units satisfy coherent physical relationships`() throws {
        let metre = SI.Unit.Name.metre.expression
        let second = SI.Unit.Name.second.expression
        let newton = SI.Unit.Name.newton.expression
        let joule = SI.Unit.Name.joule.expression
        let watt = SI.Unit.Name.watt.expression
        let ampere = SI.Unit.Name.ampere.expression
        let volt = SI.Unit.Name.volt.expression
        let pairs: [(SI.Unit.Name, SI.Unit)] = [
            (.newton, SI.Unit.Name.kilogram.expression * metre / second.raised(to: 2)),
            (.pascal, newton / metre.raised(to: 2)), (.joule, newton * metre), (.watt, joule / second),
            (.coulomb, ampere * second), (.volt, watt / ampere),
            (.farad, SI.Unit.Name.coulomb.expression / volt), (.ohm, volt / ampere),
            (.siemens, ampere / volt), (.weber, volt * second),
            (.tesla, SI.Unit.Name.weber.expression / metre.raised(to: 2)),
            (.henry, SI.Unit.Name.weber.expression / ampere),
            (.lumen, SI.Unit.Name.candela.expression * SI.Unit.Name.steradian.expression),
            (.lux, SI.Unit.Name.lumen.expression / metre.raised(to: 2)),
            (.gray, joule / SI.Unit.Name.kilogram.expression),
            (.sievert, joule / SI.Unit.Name.kilogram.expression),
            (.katal, SI.Unit.Name.mole.expression / second),
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

    @Test func `radian and steradian keep angular roles without new SI dimensions`() throws {
        let radian = SI.Unit.Name.radian.expression
        let steradian = SI.Unit.Name.steradian.expression
        #expect(radian.dimension == .one)
        #expect(steradian.dimension == .one)
        #expect(radian != steradian && radian != .one)
        #expect(SI.Quantity.planeAngle.accepts(radian))
        #expect(!SI.Quantity.planeAngle.accepts(.one))
        #expect(!SI.Quantity.planeAngle.accepts(steradian))
        #expect(SI.Quantity.solidAngle.accepts(steradian))
        let degree = SI.Brochure.Unit.degree.expression
        #expect(!degree.isSI)
        #expect(SI.Quantity.planeAngle.accepts(degree))
        let conversion = try degree.conversion(to: radian)
        #expect(conversion.piExponent == 1)
        #expect(conversion.factor.radicand * 180 == 1)
        #expect(try (degree.raised(to: 2)).conversion(to: radian.raised(to: 2)).piExponent == 2)
        #expect(throws: SI.Error.irrational) { try conversion.applying(to: 180) }
        #expect(abs(conversion.approximation * 180 - Double.pi) < 1e-14)
    }

    @Test func `prefixes are inseparable and kilogram prefixes attach to gram`() throws {
        let metre = SI.Unit.Name.metre.expression
        let centimetre = try metre.prefixed(.centi)
        #expect(try centimetre.raised(to: 3).conversion(to: metre.raised(to: 3)).factor.radicand == SI.Prefix.micro.factor)
        #expect(try centimetre.raised(to: -1).conversion(to: metre.raised(to: -1)).factor.radicand == 100)
        let milligram = try SI.Unit.Name.gram.prefixed(.milli)
        #expect(milligram.symbol == "mg")
        #expect(try milligram.conversion(to: SI.Unit.Name.kilogram.expression).factor.radicand == SI.Prefix.micro.factor)
        #expect(throws: SI.Error.prefix) { try SI.Unit.Name.kilogram.prefixed(.micro) }
        #expect(throws: SI.Error.prefix) { try centimetre.prefixed(.milli) }
        #expect(throws: SI.Error.prefix) { try SI.Unit.one.prefixed(.kilo) }
        #expect(throws: SI.Error.prefix) { try metre.raised(to: 2).prefixed(.centi) }
        #expect(!centimetre.isCoherent)
        #expect(SI.Unit.Name.kilogram.expression.isCoherent)
    }

    @Test func `Celsius coordinates and intervals have distinct laws`() throws {
        #expect(try SI.Celsius.toKelvin(0) == Rational(numerator: 27315, denominator: 100))
        for value: Rational in [-100, 0, 37, 100] {
            #expect(SI.Celsius.fromKelvin(SI.Celsius.toKelvin(value)) == value)
        }
        let celsius = SI.Unit.Name.degreeCelsius.expression
        let kelvin = SI.Unit.Name.kelvin.expression
        #expect(throws: SI.Error.affine) { try celsius.conversion(to: kelvin) }
        #expect(try celsius.intervalConversion(to: kelvin).applying(to: 10) == 10)
        #expect(!celsius.isCoherent)
        let interval = try SI.Value(10, quantity: .temperatureInterval, unit: celsius)
        #expect(try interval.converted(to: kelvin).numericalValue == 10)
    }

    @Test func `quantity descriptors reject dimensionally equal semantic substitutions`() throws {
        #expect(!SI.Quantity.frequency.accepts(SI.Unit.Name.becquerel.expression))
        #expect(!SI.Quantity.activity.accepts(SI.Unit.Name.hertz.expression))
        #expect(!SI.Quantity.torque.accepts(SI.Unit.Name.joule.expression))
        #expect(!SI.Quantity.absorbedDose.accepts(SI.Unit.Name.sievert.expression))
        #expect(!SI.Quantity.doseEquivalent.accepts(SI.Unit.Name.gray.expression))
        for quantity in SI.Quantity.brochure { #expect(quantity.accepts(quantity.unit)) }
        let energy = try SI.Value(2, quantity: .energy)
        let torque = try SI.Value(2, quantity: .torque)
        #expect(throws: SI.Error.quantity) { try energy.adding(torque) }
        let kilometre = try SI.Unit.Name.metre.prefixed(.kilo)
        let distance = try SI.Value(3, quantity: .length, unit: kilometre)
        let metres = try SI.Value(20, quantity: .length)
        #expect(try distance.adding(metres).converted(to: SI.Unit.Name.metre.expression).numericalValue == 3020)
        let duration = try SI.Value(2, quantity: .time)
        #expect(try distance.divided(by: duration, as: .speed).converted(to: SI.Quantity.speed.unit).numericalValue == 1500)
    }
}

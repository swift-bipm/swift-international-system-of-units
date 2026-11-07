internal import Rational

extension SI.Unit {
    public enum Name: String, CaseIterable, Hashable, Sendable {
        case second
        case metre
        case kilogram
        case ampere
        case kelvin
        case mole
        case candela
        case radian
        case steradian
        case hertz
        case newton
        case pascal
        case joule
        case watt
        case coulomb
        case volt
        case farad
        case ohm
        case siemens
        case weber
        case tesla
        case henry
        case degreeCelsius
        case lumen
        case lux
        case becquerel
        case gray
        case sievert
        case katal
        case gram
    }
}

extension SI.Unit.Name {
    public var name: String {
        switch self {
        case .second: "second"
        case .metre: "metre"
        case .kilogram: "kilogram"
        case .ampere: "ampere"
        case .kelvin: "kelvin"
        case .mole: "mole"
        case .candela: "candela"
        case .radian: "radian"
        case .steradian: "steradian"
        case .hertz: "hertz"
        case .newton: "newton"
        case .pascal: "pascal"
        case .joule: "joule"
        case .watt: "watt"
        case .coulomb: "coulomb"
        case .volt: "volt"
        case .farad: "farad"
        case .ohm: "ohm"
        case .siemens: "siemens"
        case .weber: "weber"
        case .tesla: "tesla"
        case .henry: "henry"
        case .degreeCelsius: "degree Celsius"
        case .lumen: "lumen"
        case .lux: "lux"
        case .becquerel: "becquerel"
        case .gray: "gray"
        case .sievert: "sievert"
        case .katal: "katal"
        case .gram: "gram"
        }
    }

    public var symbol: String {
        switch self {
        case .second: "s"
        case .metre: "m"
        case .kilogram: "kg"
        case .ampere: "A"
        case .kelvin: "K"
        case .mole: "mol"
        case .candela: "cd"
        case .radian: "rad"
        case .steradian: "sr"
        case .hertz: "Hz"
        case .newton: "N"
        case .pascal: "Pa"
        case .joule: "J"
        case .watt: "W"
        case .coulomb: "C"
        case .volt: "V"
        case .farad: "F"
        case .ohm: "Ω"
        case .siemens: "S"
        case .weber: "Wb"
        case .tesla: "T"
        case .henry: "H"
        case .degreeCelsius: "°C"
        case .lumen: "lm"
        case .lux: "lx"
        case .becquerel: "Bq"
        case .gray: "Gy"
        case .sievert: "Sv"
        case .katal: "kat"
        case .gram: "g"
        }
    }

    public var dimension: SI.Dimension {
        switch self {
        case .second: .init([.time: 1])
        case .metre: .init([.length: 1])
        case .kilogram: .init([.mass: 1])
        case .ampere: .init([.electricCurrent: 1])
        case .kelvin: .init([.thermodynamicTemperature: 1])
        case .mole: .init([.amountOfSubstance: 1])
        case .candela: .init([.luminousIntensity: 1])
        case .radian: .init([:])
        case .steradian: .init([:])
        case .hertz: .init([.time: -1])
        case .newton: .init([.time: -2, .length: 1, .mass: 1])
        case .pascal: .init([.time: -2, .length: -1, .mass: 1])
        case .joule: .init([.time: -2, .length: 2, .mass: 1])
        case .watt: .init([.time: -3, .length: 2, .mass: 1])
        case .coulomb: .init([.time: 1, .electricCurrent: 1])
        case .volt: .init([.time: -3, .length: 2, .mass: 1, .electricCurrent: -1])
        case .farad: .init([.time: 4, .length: -2, .mass: -1, .electricCurrent: 2])
        case .ohm: .init([.time: -3, .length: 2, .mass: 1, .electricCurrent: -2])
        case .siemens: .init([.time: 3, .length: -2, .mass: -1, .electricCurrent: 2])
        case .weber: .init([.time: -2, .length: 2, .mass: 1, .electricCurrent: -1])
        case .tesla: .init([.time: -2, .mass: 1, .electricCurrent: -1])
        case .henry: .init([.time: -2, .length: 2, .mass: 1, .electricCurrent: -2])
        case .degreeCelsius: .init([.thermodynamicTemperature: 1])
        case .lumen: .init([.luminousIntensity: 1])
        case .lux: .init([.length: -2, .luminousIntensity: 1])
        case .becquerel: .init([.time: -1])
        case .gray: .init([.time: -2, .length: 2])
        case .sievert: .init([.time: -2, .length: 2])
        case .katal: .init([.time: -1, .amountOfSubstance: 1])
        case .gram: .init([.mass: 1])
        }
    }

    public var expression: SI.Unit { SI.Unit(self) }

    public func prefixed(_ prefix: SI.Prefix) throws(SI.Error) -> SI.Unit {
        try expression.prefixed(prefix)
    }

    public static var base: [Self] { SI.Base.allCases.map(\.unit) }

    public static var special: [Self] { allCases.filter { !base.contains($0) && $0 != .gram } }
}

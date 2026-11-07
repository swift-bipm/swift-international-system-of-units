public import Rational

extension SI {
    public enum Prefix: Int, CaseIterable, Hashable, Sendable {
        case quetta = 30
        case ronna = 27
        case yotta = 24
        case zetta = 21
        case exa = 18
        case peta = 15
        case tera = 12
        case giga = 9
        case mega = 6
        case kilo = 3
        case hecto = 2
        case deca = 1
        case deci = -1
        case centi = -2
        case milli = -3
        case micro = -6
        case nano = -9
        case pico = -12
        case femto = -15
        case atto = -18
        case zepto = -21
        case yocto = -24
        case ronto = -27
        case quecto = -30
    }
}

extension SI.Prefix {
    public var exponent: Int { rawValue }

    public var name: String {
        switch self {
        case .quetta: "quetta"
        case .ronna: "ronna"
        case .yotta: "yotta"
        case .zetta: "zetta"
        case .exa: "exa"
        case .peta: "peta"
        case .tera: "tera"
        case .giga: "giga"
        case .mega: "mega"
        case .kilo: "kilo"
        case .hecto: "hecto"
        case .deca: "deca"
        case .deci: "deci"
        case .centi: "centi"
        case .milli: "milli"
        case .micro: "micro"
        case .nano: "nano"
        case .pico: "pico"
        case .femto: "femto"
        case .atto: "atto"
        case .zepto: "zepto"
        case .yocto: "yocto"
        case .ronto: "ronto"
        case .quecto: "quecto"
        }
    }

    public var symbol: String {
        switch self {
        case .quetta: "Q"
        case .ronna: "R"
        case .yotta: "Y"
        case .zetta: "Z"
        case .exa: "E"
        case .peta: "P"
        case .tera: "T"
        case .giga: "G"
        case .mega: "M"
        case .kilo: "k"
        case .hecto: "h"
        case .deca: "da"
        case .deci: "d"
        case .centi: "c"
        case .milli: "m"
        case .micro: "µ"
        case .nano: "n"
        case .pico: "p"
        case .femto: "f"
        case .atto: "a"
        case .zepto: "z"
        case .yocto: "y"
        case .ronto: "r"
        case .quecto: "q"
        }
    }

    public var factor: Rational {
        do {
            return try Rational(10).raised(to: exponent)
        } catch {
            preconditionFailure("The fixed definition must be representable and have a nonzero divisor")
        }
    }
}

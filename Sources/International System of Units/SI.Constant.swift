public import Rational

extension SI {
    public enum Constant: String, CaseIterable, Hashable, Sendable {
        case caesiumFrequency
        case speedOfLight
        case planck
        case elementaryCharge
        case boltzmann
        case avogadro
        case luminousEfficacy
    }
}

extension SI.Constant {
    public var symbol: String {
        switch self {
        case .caesiumFrequency: "ΔνCs"
        case .speedOfLight: "c"
        case .planck: "h"
        case .elementaryCharge: "e"
        case .boltzmann: "k"
        case .avogadro: "NA"
        case .luminousEfficacy: "Kcd"
        }
    }

    public var name: String {
        switch self {
        case .caesiumFrequency: "unperturbed ground-state hyperfine transition frequency of the caesium 133 atom"
        case .speedOfLight: "speed of light in vacuum"
        case .planck: "Planck constant"
        case .elementaryCharge: "elementary charge"
        case .boltzmann: "Boltzmann constant"
        case .avogadro: "Avogadro constant"
        case .luminousEfficacy: "luminous efficacy of monochromatic radiation of frequency 540 × 10¹² Hz"
        }
    }

    public var significand: Rational {
        do {
            return switch self {
            case .caesiumFrequency: 9_192_631_770
            case .speedOfLight: 299_792_458
            case .planck: try Rational(numerator: 662_607_015, denominator: 100_000_000)
            case .elementaryCharge: try Rational(numerator: 1_602_176_634, denominator: 1_000_000_000)
            case .boltzmann: try Rational(numerator: 1_380_649, denominator: 1_000_000)
            case .avogadro: try Rational(numerator: 602_214_076, denominator: 100_000_000)
            case .luminousEfficacy: 683
            }
        } catch {
            preconditionFailure("The fixed definition must be representable and have a nonzero divisor")
        }
    }

    public var exponent: Int {
        switch self {
        case .planck: -34
        case .elementaryCharge: -19
        case .boltzmann: -23
        case .avogadro: 23
        default: 0
        }
    }

    public var numericalValue: Rational {
        do {
            return significand * (try Rational(10).raised(to: exponent))
        } catch {
            preconditionFailure("The fixed definition must be representable and have a nonzero divisor")
        }
    }

    public var unit: SI.Unit {
        switch self {
        case .caesiumFrequency: SI.Unit.Name.hertz.expression
        case .speedOfLight: SI.Unit.Name.metre.expression / SI.Unit.Name.second.expression
        case .planck: SI.Unit.Name.joule.expression * SI.Unit.Name.second.expression
        case .elementaryCharge: SI.Unit.Name.coulomb.expression
        case .boltzmann: SI.Unit.Name.joule.expression / SI.Unit.Name.kelvin.expression
        case .avogadro: SI.Unit.Name.mole.expression.raised(to: -1)
        case .luminousEfficacy: SI.Unit.Name.lumen.expression / SI.Unit.Name.watt.expression
        }
    }

    public static var photometricFrequency: Rational { 540_000_000_000_000 }
}

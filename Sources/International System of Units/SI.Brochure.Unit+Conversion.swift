import Rational

extension SI.Brochure.Unit {
    public var conversion: SI.Conversion {
        get throws(SI.Error) {
            if self == .dalton { throw .experimental }
            if [.neper, .bel, .decibel].contains(self) { throw .logarithmic }
            do {
                switch self {
                case .minute: return .init(Rational(60))
                case .hour: return .init(Rational(3600))
                case .day: return .init(Rational(86400))
                case .degree: return .init(try (Rational(1)).divided(by: 180), piExponent: 1)
                case .arcminute: return .init(try (Rational(1)).divided(by: 10800), piExponent: 1)
                case .arcsecond: return .init(try (Rational(1)).divided(by: 648000), piExponent: 1)
                case .are: return .init(Rational(1) * (try Rational(10).raised(to: 2)))
                case .hectare: return .init(Rational(1) * (try Rational(10).raised(to: 4)))
                case .barn: return .init(Rational(1) * (try Rational(10).raised(to: -28)))
                case .litre: return .init(Rational(1) * (try Rational(10).raised(to: -3)))
                case .tonne: return .init(Rational(1) * (try Rational(10).raised(to: 3)))
                case .angstrom: return .init(Rational(1) * (try Rational(10).raised(to: -10)))
                case .gal: return .init(Rational(1) * (try Rational(10).raised(to: -2)))
                case .bar: return .init(Rational(1) * (try Rational(10).raised(to: 5)))
                case .dalton: preconditionFailure("Experimental value requires an estimate")
                case .astronomicalUnit: return .init(Rational(149_597_870_700))
                case .nauticalMile: return .init(Rational(1852))
                case .knot: return .init(try (Rational(1852)).divided(by: 3600))
                case .electronvolt: return .init(Rational(1_602_176_634) * (try Rational(10).raised(to: -28)))
                case .neper: preconditionFailure("Logarithmic quantity required")
                case .bel: preconditionFailure("Logarithmic quantity required")
                case .decibel: preconditionFailure("Logarithmic quantity required")
                case .var: return .init(Rational(1))
                case .atmosphere: return .init(Rational(101325))
                case .curie: return .init(Rational(37) * (try Rational(10).raised(to: 9)))
                case .enzymeUnit: return .init(try (Rational(1) * (try Rational(10).raised(to: -6))).divided(by: 60))
                }
            } catch { preconditionFailure("A fixed conversion has a nonzero divisor") }
        }
    }
}

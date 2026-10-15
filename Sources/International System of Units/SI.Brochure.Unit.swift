internal import Rational

extension SI.Brochure {
    public enum Unit: String, CaseIterable, Hashable, Sendable {
        case minute
        case hour
        case day
        case degree
        case arcminute
        case arcsecond
        case are
        case hectare
        case barn
        case litre
        case tonne
        case angstrom
        case gal
        case bar
        case dalton
        case astronomicalUnit
        case nauticalMile
        case knot
        case electronvolt
        case neper
        case bel
        case decibel
        case `var`
        case atmosphere
        case curie
        case enzymeUnit

        public var name: String {
            switch self {
            case .minute: "minute"
            case .hour: "hour"
            case .day: "day"
            case .degree: "degree"
            case .arcminute: "minute"
            case .arcsecond: "second"
            case .are: "are"
            case .hectare: "hectare"
            case .barn: "barn"
            case .litre: "litre"
            case .tonne: "tonne"
            case .angstrom: "angstrom"
            case .gal: "gal"
            case .bar: "bar"
            case .dalton: "dalton"
            case .astronomicalUnit: "astronomical unit"
            case .nauticalMile: "nautical mile"
            case .knot: "knot"
            case .electronvolt: "electronvolt"
            case .neper: "neper"
            case .bel: "bel"
            case .decibel: "decibel"
            case .var: "var"
            case .atmosphere: "standard atmosphere"
            case .curie: "curie"
            case .enzymeUnit: "unit"
            }
        }
        public var symbols: [String] {
            switch self {
            case .minute: ["min"]
            case .hour: ["h"]
            case .day: ["d"]
            case .degree: ["°"]
            case .arcminute: ["′"]
            case .arcsecond: ["″", "as"]
            case .are: ["a"]
            case .hectare: ["ha"]
            case .barn: ["b"]
            case .litre: ["l", "L"]
            case .tonne: ["t"]
            case .angstrom: ["Å"]
            case .gal: ["Gal"]
            case .bar: ["bar"]
            case .dalton: ["Da", "u"]
            case .astronomicalUnit: ["au"]
            case .nauticalMile: []
            case .knot: []
            case .electronvolt: ["eV"]
            case .neper: ["Np"]
            case .bel: ["B"]
            case .decibel: ["dB"]
            case .var: ["var"]
            case .atmosphere: ["atm"]
            case .curie: ["Ci"]
            case .enzymeUnit: ["U"]
            }
        }
        public var dimension: SI.Dimension {
            switch self {
            case .minute: .init([.time: 1])
            case .hour: .init([.time: 1])
            case .day: .init([.time: 1])
            case .degree: .init([:])
            case .arcminute: .init([:])
            case .arcsecond: .init([:])
            case .are: .init([.length: 2])
            case .hectare: .init([.length: 2])
            case .barn: .init([.length: 2])
            case .litre: .init([.length: 3])
            case .tonne: .init([.mass: 1])
            case .angstrom: .init([.length: 1])
            case .gal: .init([.time: -2, .length: 1])
            case .bar: .init([.time: -2, .length: -1, .mass: 1])
            case .dalton: .init([.mass: 1])
            case .astronomicalUnit: .init([.length: 1])
            case .nauticalMile: .init([.length: 1])
            case .knot: .init([.time: -1, .length: 1])
            case .electronvolt: .init([.time: -2, .length: 2, .mass: 1])
            case .neper: .init([:])
            case .bel: .init([:])
            case .decibel: .init([:])
            case .var: .init([.time: -3, .length: 2, .mass: 1])
            case .atmosphere: .init([.time: -2, .length: -1, .mass: 1])
            case .curie: .init([.time: -1])
            case .enzymeUnit: .init([.time: -1, .amountOfSubstance: 1])
            }
        }
        public var category: Category {
            switch self {
            case .minute: .longStanding
            case .hour: .longStanding
            case .day: .longStanding
            case .degree: .longStanding
            case .arcminute: .longStanding
            case .arcsecond: .longStanding
            case .are: .decimal
            case .hectare: .decimal
            case .barn: .decimal
            case .litre: .decimal
            case .tonne: .decimal
            case .angstrom: .decimal
            case .gal: .decimal
            case .bar: .decimal
            case .dalton: .international
            case .astronomicalUnit: .international
            case .nauticalMile: .international
            case .knot: .international
            case .electronvolt: .international
            case .neper: .technical
            case .bel: .technical
            case .decibel: .technical
            case .var: .technical
            case .atmosphere: .appendix
            case .curie: .appendix
            case .enzymeUnit: .appendix
            }
        }
        public var expression: SI.Unit { SI.Unit(self) }
        public static var table8: [Self] { allCases.filter { $0.category != .appendix } }
        public var permitsPrefix: Bool {
            switch self {
            case .litre, .tonne, .barn, .bar, .gal, .dalton, .electronvolt, .neper, .bel,
                .var, .curie, .enzymeUnit, .arcsecond:
                true
            default: false
            }
        }
    }
}

extension SI {
    public enum Base: String, CaseIterable, Hashable, Sendable {
        case time
        case length
        case mass
        case electricCurrent
        case thermodynamicTemperature
        case amountOfSubstance
        case luminousIntensity
    }
}

extension SI.Base {
    public var symbol: String {
        switch self {
        case .time: "T"
        case .length: "L"
        case .mass: "M"
        case .electricCurrent: "I"
        case .thermodynamicTemperature: "Θ"
        case .amountOfSubstance: "N"
        case .luminousIntensity: "J"
        }
    }

    public var unit: SI.Unit.Name {
        switch self {
        case .time: .second
        case .length: .metre
        case .mass: .kilogram
        case .electricCurrent: .ampere
        case .thermodynamicTemperature: .kelvin
        case .amountOfSubstance: .mole
        case .luminousIntensity: .candela
        }
    }
}

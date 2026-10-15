extension SI.Base {
    public var definition: SI.Definition {
        switch self {
        case .time: .init([.caesiumFrequency: -1])
        case .length: .init([.speedOfLight: 1, .caesiumFrequency: -1])
        case .mass: .init([.planck: 1, .caesiumFrequency: 1, .speedOfLight: -2])
        case .electricCurrent: .init([.elementaryCharge: 1, .caesiumFrequency: 1])
        case .thermodynamicTemperature: .init([.planck: 1, .caesiumFrequency: 1, .boltzmann: -1])
        case .amountOfSubstance: .init([.avogadro: -1])
        case .luminousIntensity: .init([.planck: 1, .caesiumFrequency: 2, .luminousEfficacy: 1], steradianExponent: -1)
        }
    }
}

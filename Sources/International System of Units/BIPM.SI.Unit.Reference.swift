extension BIPM.SI.Unit {
    public enum Reference: Hashable, Sendable {
        case si(BIPM.SI.Unit.Name)
        case brochure(BIPM.SI.Brochure.Unit)
    }
}

extension BIPM.SI.Unit.Reference {
    public var name: String {
        switch self {
        case .si(let unit): unit.name
        case .brochure(let unit): unit.name
        }
    }

    public var symbols: [String] {
        switch self {
        case .si(let unit): [unit.symbol]
        case .brochure(let unit): unit.symbols
        }
    }

    public var dimension: BIPM.SI.Dimension {
        switch self {
        case .si(let unit): unit.dimension
        case .brochure(let unit): unit.dimension
        }
    }
}

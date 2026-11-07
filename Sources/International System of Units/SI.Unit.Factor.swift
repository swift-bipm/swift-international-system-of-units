extension SI.Unit {
    public struct Factor: Hashable, Sendable {
        public let reference: Reference
        public let prefix: SI.Prefix?
        public let spelling: String?

        internal init(_ reference: Reference, prefix: SI.Prefix? = nil, spelling: String? = nil) {
            self.reference = reference
            self.prefix = prefix
            self.spelling = spelling
        }
    }
}

extension SI.Unit.Factor {
    public var symbol: String? {
        guard let symbol = spelling ?? reference.symbols.first else { return nil }
        return (prefix?.symbol ?? "") + symbol
    }

    public var name: String { (prefix?.name ?? "") + reference.name }
}

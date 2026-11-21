extension BIPM.SI.Unit {
    public struct Factor: Hashable, Sendable {
        public let reference: Reference
        public let prefix: BIPM.SI.Prefix?
        public let spelling: String?

        internal init(_ reference: Reference, prefix: BIPM.SI.Prefix? = nil, spelling: String? = nil) {
            self.reference = reference
            self.prefix = prefix
            self.spelling = spelling
        }
    }
}

extension BIPM.SI.Unit.Factor {
    public var symbol: String? {
        guard let symbol = spelling ?? reference.symbols.first else { return nil }
        return (prefix?.symbol ?? "") + symbol
    }

    public var name: String { (prefix?.name ?? "") + reference.name }
}

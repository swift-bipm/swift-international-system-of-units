extension SI {
    public enum Error: Swift.Error, Hashable, Sendable {
        case prefix
        case dimension
        case quantity
        case affine
        case experimental
        case logarithmic
        case irrational
        case zero
        case exponent
        case syntax
        case ambiguous
    }
}

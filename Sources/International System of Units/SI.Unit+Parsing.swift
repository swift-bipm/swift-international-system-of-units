extension SI.Unit {
    public init(symbol: String, scope: Scope = .all) throws(SI.Error) {
        var parser = Parser(characters: Array(symbol), scope: scope)
        let result = try parser.expression()
        _ = parser.space()
        guard parser.index == parser.characters.count else { throw .syntax }
        self = result
    }
}

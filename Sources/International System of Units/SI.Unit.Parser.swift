internal import Rational

extension SI.Unit {
    internal struct Parser {
        internal let characters: [Character]
        internal let scope: Scope
        internal var index = 0

        internal mutating func space() -> Bool {
            let start = index
            while index < characters.count && characters[index].isWhitespace { index += 1 }
            return index != start
        }
        internal mutating func expression() throws(SI.Error) -> SI.Unit {
            _ = space()
            var result = try primary()
            var divided = false
            while index < characters.count {
                let separated = space()
                if index == characters.count || characters[index] == ")" { break }
                let next = characters[index]
                if next == "/" {
                    guard !divided else { throw .syntax }
                    divided = true
                    index += 1
                    _ = space()
                    result = try result.multiplied(by: primary().power(-1))
                } else if next == "⋅" || next == "·" {
                    index += 1
                    _ = space()
                    result = try result.multiplied(by: primary())
                } else if separated {
                    result = try result.multiplied(by: primary())
                } else {
                    throw .syntax
                }
            }
            return result
        }
        internal mutating func primary() throws(SI.Error) -> SI.Unit {
            guard index < characters.count else { throw .syntax }
            var result: SI.Unit
            if characters[index] == "(" {
                index += 1
                result = try expression()
                guard index < characters.count, characters[index] == ")" else { throw .syntax }
                index += 1
            } else {
                let start = index
                while index < characters.count && !characters[index].isWhitespace
                    && !"⋅·/()^⁰¹²³⁴⁵⁶⁷⁸⁹⁻".contains(characters[index])
                {
                    index += 1
                }
                guard start != index else { throw .syntax }
                result = try Self.atom(String(characters[start..<index]), scope: scope)
            }
            if index < characters.count && characters[index] == "^" {
                index += 1
                let grouped = index < characters.count && characters[index] == "("
                if grouped { index += 1 }
                let start = index
                while index < characters.count && "+-0123456789".contains(characters[index]) { index += 1 }
                var text = String(characters[start..<index])
                let negative = text.first == "-"
                if text.first == "-" || text.first == "+" { text.removeFirst() }
                guard let numerator = Integer(text) else { throw .syntax }
                var denominator: Integer = 1
                if grouped && index < characters.count && characters[index] == "/" {
                    index += 1
                    let start = index
                    while index < characters.count && "0123456789".contains(characters[index]) { index += 1 }
                    guard let value = Integer(String(characters[start..<index])), value != 0 else { throw .syntax }
                    denominator = value
                }
                if grouped {
                    guard index < characters.count, characters[index] == ")" else { throw .syntax }
                    index += 1
                }
                let exponent: Rational
                do { exponent = try Rational(numerator: numerator, denominator: denominator) }
                catch { throw .exponent }
                result = result.power(negative ? -exponent : exponent)
            } else {
                let digits: [Character: Character] = ["⁰": "0", "¹": "1", "²": "2", "³": "3", "⁴": "4", "⁵": "5", "⁶": "6", "⁷": "7", "⁸": "8", "⁹": "9", "⁻": "-"]
                var exponent = ""
                while index < characters.count, let digit = digits[characters[index]] {
                    exponent.append(digit)
                    index += 1
                }
                if !exponent.isEmpty {
                    guard let power = Integer(exponent) else { throw .syntax }
                    result = result.power(Rational(power))
                }
            }
            return result
        }
        internal static func atom(_ token: String, scope: Scope) throws(SI.Error) -> SI.Unit {
            if token == "1" { return .one }
            var candidates: Set<SI.Unit> = []
            let named = scope == .brochure ? nil : SI.Unit.Name.allCases.first(where: { $0.symbol == token })
            let brochure = scope == .si ? nil : SI.Brochure.Unit.allCases.first(where: { $0.symbols.contains(token) })
            if let named {
                candidates.insert(named.expression)
            }
            if let brochure {
                candidates.insert(try brochure.expression.spelled(token))
            }
            for prefix in SI.Prefix.allCases {
                guard token.hasPrefix(prefix.symbol) else { continue }
                let symbol = String(token.dropFirst(prefix.symbol.count))
                if scope != .brochure, named == nil, let unit = SI.Unit.Name.allCases.first(where: { $0.symbol == symbol }) {
                    do { candidates.insert(try unit.prefixed(prefix)) }
                    catch { if error != .prefix { throw error } }
                }
                if scope != .si, brochure == nil, let unit = SI.Brochure.Unit.allCases.first(where: { $0.symbols.contains(symbol) }) {
                    do { candidates.insert(try unit.expression.spelled(symbol).prefixed(prefix)) }
                    catch { if error != .prefix { throw error } }
                }
            }
            guard candidates.count <= 1 else { throw .ambiguous }
            guard let unit = candidates.first else { throw .syntax }
            return unit
        }
    }
}

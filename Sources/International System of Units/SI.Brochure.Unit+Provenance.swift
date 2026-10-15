extension SI.Brochure.Unit {
    public var source: String {
        switch self {
        case .astronomicalUnit: "IAU, 2012 Resolution B2; SI Brochure Table 8(j)"
        case .nauticalMile, .knot: "International Hydrographic Conference, 1929; SI Brochure Table 8(k)"
        case .dalton: "CODATA 2022; SI Brochure Table 8(i); one twelfth of a free carbon 12 atom at rest in its ground state"
        case .are, .hectare, .litre, .tonne: "CIPM 1879; SI Brochure Table 8"
        case .bar: "9th CGPM, 1948 Resolution 7; SI Brochure Table 8(h)"
        case .atmosphere: "10th CGPM, 1954 Resolution 4; SI Brochure Appendix 1, p. 158"
        case .curie: "12th CGPM, 1964 Resolution 7; SI Brochure Appendix 1, p. 163"
        case .enzymeUnit: "21st CGPM, 1999 Resolution 12 (acknowledgement); SI Brochure Appendix 1, p. 177"
        default: "BIPM SI Brochure, version 4.01, Table 8 (reference, not SI membership)"
        }
    }
    public var admission: String? {
        switch self {
        case .litre: "16th CGPM, 1979 Resolution 6: admitted for general use with SI"
        case .curie: "12th CGPM, 1964 Resolution 7: retained outside SI"
        default: nil
        }
    }
}

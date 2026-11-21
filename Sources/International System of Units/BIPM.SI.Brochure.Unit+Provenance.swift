extension BIPM.SI.Brochure.Unit {
    public var source: String {
        switch self {
        case .astronomicalUnit: "IAU, 2012 Resolution B2; BIPM.SI Brochure Table 8(j)"
        case .nauticalMile, .knot: "International Hydrographic Conference, 1929; BIPM.SI Brochure Table 8(k)"
        case .dalton: "CODATA 2022; BIPM.SI Brochure Table 8(i); one twelfth of a free carbon 12 atom at rest in its ground state"
        case .are, .hectare, .litre, .tonne: "CIPM 1879; BIPM.SI Brochure Table 8"
        case .bar: "9th CGPM, 1948 Resolution 7; BIPM.SI Brochure Table 8(h)"
        case .atmosphere: "10th CGPM, 1954 Resolution 4; BIPM.SI Brochure Appendix 1, p. 158"
        case .curie: "12th CGPM, 1964 Resolution 7; BIPM.SI Brochure Appendix 1, p. 163"
        case .enzymeUnit: "21st CGPM, 1999 Resolution 12 (acknowledgement); BIPM.SI Brochure Appendix 1, p. 177"
        default: "BIPM BIPM.SI Brochure, version 4.01, Table 8 (reference, not BIPM.SI membership)"
        }
    }
    public var admission: String? {
        switch self {
        case .litre: "16th CGPM, 1979 Resolution 6: admitted for general use with BIPM.SI"
        case .curie: "12th CGPM, 1964 Resolution 7: retained outside BIPM.SI"
        default: nil
        }
    }
}

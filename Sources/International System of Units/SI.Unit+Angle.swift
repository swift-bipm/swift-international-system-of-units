public import Rational

extension SI.Unit {
    public var angular: (plane: Rational, solid: Rational) {
        var plane: Rational = 0
        var solid: Rational = 0
        for (factor, power) in factors {
            switch factor.reference {
            case .si(.radian), .brochure(.degree), .brochure(.arcminute), .brochure(.arcsecond): plane = plane + power
            case .si(.steradian), .si(.lumen), .si(.lux): solid = solid + power
            default: break
            }
        }
        return (plane, solid)
    }
}

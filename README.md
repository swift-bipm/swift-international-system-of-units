# swift-international-system-of-units

Use this package when you need SI units, quantities and conversions to be exact and checked against the SI Brochure (ninth edition), not just dimensionally consistent. Start from `SI.Value` for an amount of a quantity in a unit, `SI.Unit` to build or parse unit expressions, and `SI.Quantity` for the kind of quantity, which decides which units are allowed. If you only need the decimal prefixes as data, use swift-iso-80000-1.

## Laws

- Every defining constant, prefix and conversion factor is an exact rational. A conversion that involves π, such as degrees to radians, stays exact as a power of π. Applying it to a nonzero number fails with `SI.Error.irrational`. Use `SI.Conversion.approximation` or `SI.Value.approximation(in:)` for a `Double`.
- Matching dimensions is not enough for a quantity. Frequency refuses becquerel, activity refuses hertz, torque refuses joule, absorbed dose refuses sievert and dose equivalent refuses gray. Values of different quantities can't be added, even when they share a dimension, and are never equal.
- Radian and steradian are dimensionless but stay distinct. A plane angle needs exactly one plane angle unit, so it accepts radian or degree but not `SI.Unit.one` or steradian.
- Degree Celsius is an offset scale. `SI.Unit.conversion(to:)` refuses it with `SI.Error.affine`. `SI.Unit.intervalConversion(to:)` treats one degree Celsius as one kelvin. A `SI.Quantity.celsiusTemperature` accepts only degree Celsius, and a thermodynamic temperature refuses it.
- A prefix attaches only to a single unprefixed unit with power 1, and it binds before any exponent, so cm³ is 10⁻⁶ m³. Kilogram takes no prefix. Prefixes go on gram, and kilo on gram gives kilogram. Of the non-SI units, only those the Brochure allows take a prefix, and the arcsecond only when spelled `as`.
- Dalton has no exact conversion and fails with `SI.Error.experimental`. Use `SI.Brochure.Estimate.dalton` for its measured value and uncertainty. Neper, bel and decibel fail with `SI.Error.logarithmic`. `SI.Brochure.Logarithm.conversion(to:)` converts between bel and decibel but not to or from neper.
- `SI.Unit.init(symbol:scope:)` multiplies on a space, `⋅` or `·`, and allows at most one `/`. A power follows `^`, as a whole number or as a fraction in parentheses, or is written in superscript digits. A symbol that could mean more than one unit fails with `SI.Error.ambiguous`, as `as` does for attosecond and arcsecond. Pass a narrower `SI.Unit.Scope` to choose.
- Two `SI.Value`s of the same quantity are equal, and hash alike, when they are the same amount after both units are reduced to coherent SI. So 2 m equals 200 cm, and zero in any unit equals zero in any other.
- `SI.Unit.symbol` sorts its factors and joins them with `⋅`, with integer powers as superscripts. It is nil when any factor has no symbol, as for the nautical mile and the knot. `SI.Unit.formatted(_:)` puts a space before the symbol except for °, ′ and ″.
- A unit is coherent only if it uses SI units alone, has no degree Celsius, and converts to the coherent SI unit with factor exactly 1. Kilogram is coherent and centimetre is not.
- `SI.Notation.decimal(_:marker:)` accepts an optional sign, ASCII digits and at most one decimal marker with digits on both sides. Digit grouping separators are refused.

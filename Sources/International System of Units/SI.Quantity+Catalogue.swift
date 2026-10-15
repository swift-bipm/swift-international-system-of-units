extension SI.Quantity {
    public static let time = Self(name: "time", unit: SI.Unit.Name.second.expression)
    public static let length = Self(name: "length", unit: SI.Unit.Name.metre.expression)
    public static let mass = Self(name: "mass", unit: SI.Unit.Name.kilogram.expression)
    public static let electricCurrent = Self(name: "electric current", unit: SI.Unit.Name.ampere.expression)
    public static let thermodynamicTemperature = Self(name: "thermodynamic temperature", unit: SI.Unit.Name.kelvin.expression)
    public static let amountOfSubstance = Self(name: "amount of substance", unit: SI.Unit.Name.mole.expression)
    public static let luminousIntensity = Self(name: "luminous intensity", unit: SI.Unit.Name.candela.expression)
    public static let planeAngle = Self(name: "plane angle", unit: SI.Unit.Name.radian.expression)
    public static let phaseAngle = Self(name: "phase angle", unit: SI.Unit.Name.radian.expression)
    public static let solidAngle = Self(name: "solid angle", unit: SI.Unit.Name.steradian.expression)
    public static let frequency = Self(name: "frequency", unit: SI.Unit.Name.hertz.expression)
    public static let force = Self(name: "force", unit: SI.Unit.Name.newton.expression)
    public static let pressure = Self(name: "pressure", unit: SI.Unit.Name.pascal.expression)
    public static let stress = Self(name: "stress", unit: SI.Unit.Name.pascal.expression)
    public static let energy = Self(name: "energy", unit: SI.Unit.Name.joule.expression)
    public static let work = Self(name: "work", unit: SI.Unit.Name.joule.expression)
    public static let heat = Self(name: "amount of heat", unit: SI.Unit.Name.joule.expression)
    public static let power = Self(name: "power", unit: SI.Unit.Name.watt.expression)
    public static let radiantFlux = Self(name: "radiant flux", unit: SI.Unit.Name.watt.expression)
    public static let electricCharge = Self(name: "electric charge", unit: SI.Unit.Name.coulomb.expression)
    public static let potentialDifference = Self(name: "electric potential difference", unit: SI.Unit.Name.volt.expression)
    public static let capacitance = Self(name: "capacitance", unit: SI.Unit.Name.farad.expression)
    public static let resistance = Self(name: "electric resistance", unit: SI.Unit.Name.ohm.expression)
    public static let conductance = Self(name: "electric conductance", unit: SI.Unit.Name.siemens.expression)
    public static let magneticFlux = Self(name: "magnetic flux", unit: SI.Unit.Name.weber.expression)
    public static let magneticFluxDensity = Self(name: "magnetic flux density", unit: SI.Unit.Name.tesla.expression)
    public static let inductance = Self(name: "inductance", unit: SI.Unit.Name.henry.expression)
    public static let celsiusTemperature = Self(name: "Celsius temperature", unit: SI.Unit.Name.degreeCelsius.expression)
    public static let temperatureInterval = Self(name: "temperature interval", unit: SI.Unit.Name.kelvin.expression)
    public static let luminousFlux = Self(name: "luminous flux", unit: SI.Unit.Name.lumen.expression)
    public static let illuminance = Self(name: "illuminance", unit: SI.Unit.Name.lux.expression)
    public static let activity = Self(name: "activity referred to a radionuclide", unit: SI.Unit.Name.becquerel.expression)
    public static let absorbedDose = Self(name: "absorbed dose", unit: SI.Unit.Name.gray.expression)
    public static let kerma = Self(name: "kerma", unit: SI.Unit.Name.gray.expression)
    public static let doseEquivalent = Self(name: "dose equivalent", unit: SI.Unit.Name.sievert.expression)
    public static let catalyticActivity = Self(name: "catalytic activity", unit: SI.Unit.Name.katal.expression)
    public static let area = Self(name: "area", unit: SI.Unit.Name.metre.expression.raised(to: 2))
    public static let volume = Self(name: "volume", unit: SI.Unit.Name.metre.expression.raised(to: 3))
    public static let speed = Self(name: "speed", unit: SI.Unit.Name.metre.expression / SI.Unit.Name.second.expression)
    public static let velocity = Self(name: "velocity", unit: SI.Unit.Name.metre.expression / SI.Unit.Name.second.expression)
    public static let acceleration = Self(name: "acceleration", unit: SI.Unit.Name.metre.expression / SI.Unit.Name.second.expression.raised(to: 2))
    public static let wavenumber = Self(name: "wavenumber", unit: SI.Unit.Name.metre.expression.raised(to: -1))
    public static let density = Self(name: "mass density", unit: SI.Unit.Name.kilogram.expression / SI.Unit.Name.metre.expression.raised(to: 3))
    public static let surfaceDensity = Self(name: "surface density", unit: SI.Unit.Name.kilogram.expression / SI.Unit.Name.metre.expression.raised(to: 2))
    public static let specificVolume = Self(name: "specific volume", unit: SI.Unit.Name.metre.expression.raised(to: 3) / SI.Unit.Name.kilogram.expression)
    public static let currentDensity = Self(name: "current density", unit: SI.Unit.Name.ampere.expression / SI.Unit.Name.metre.expression.raised(to: 2))
    public static let magneticFieldStrength = Self(name: "magnetic field strength", unit: SI.Unit.Name.ampere.expression / SI.Unit.Name.metre.expression)
    public static let amountConcentration = Self(name: "amount-of-substance concentration", unit: SI.Unit.Name.mole.expression / SI.Unit.Name.metre.expression.raised(to: 3))
    public static let massConcentration = Self(name: "mass concentration", unit: SI.Unit.Name.kilogram.expression / SI.Unit.Name.metre.expression.raised(to: 3))
    public static let luminance = Self(name: "luminance", unit: SI.Unit.Name.candela.expression / SI.Unit.Name.metre.expression.raised(to: 2))
    public static let dynamicViscosity = Self(name: "dynamic viscosity", unit: SI.Unit.Name.pascal.expression * SI.Unit.Name.second.expression)
    public static let torque = Self(name: "moment of force, torque", unit: SI.Unit.Name.newton.expression * SI.Unit.Name.metre.expression)
    public static let surfaceTension = Self(name: "surface tension", unit: SI.Unit.Name.newton.expression / SI.Unit.Name.metre.expression)
    public static let angularVelocity = Self(name: "angular velocity", unit: SI.Unit.Name.radian.expression / SI.Unit.Name.second.expression)
    public static let angularFrequency = Self(name: "angular frequency", unit: SI.Unit.Name.radian.expression / SI.Unit.Name.second.expression)
    public static let angularAcceleration = Self(name: "angular acceleration", unit: SI.Unit.Name.radian.expression / SI.Unit.Name.second.expression.raised(to: 2))
    public static let heatFluxDensity = Self(name: "heat flux density", unit: SI.Unit.Name.watt.expression / SI.Unit.Name.metre.expression.raised(to: 2))
    public static let irradiance = Self(name: "irradiance", unit: SI.Unit.Name.watt.expression / SI.Unit.Name.metre.expression.raised(to: 2))
    public static let heatCapacity = Self(name: "heat capacity", unit: SI.Unit.Name.joule.expression / SI.Unit.Name.kelvin.expression)
    public static let entropy = Self(name: "entropy", unit: SI.Unit.Name.joule.expression / SI.Unit.Name.kelvin.expression)
    public static let specificHeatCapacity = Self(name: "specific heat capacity", unit: SI.Unit.Name.joule.expression / SI.Unit.Name.kilogram.expression / SI.Unit.Name.kelvin.expression)
    public static let specificEntropy = Self(name: "specific entropy", unit: SI.Unit.Name.joule.expression / SI.Unit.Name.kilogram.expression / SI.Unit.Name.kelvin.expression)
    public static let specificEnergy = Self(name: "specific energy", unit: SI.Unit.Name.joule.expression / SI.Unit.Name.kilogram.expression)
    public static let thermalConductivity = Self(name: "thermal conductivity", unit: SI.Unit.Name.watt.expression / SI.Unit.Name.metre.expression / SI.Unit.Name.kelvin.expression)
    public static let energyDensity = Self(name: "energy density", unit: SI.Unit.Name.joule.expression / SI.Unit.Name.metre.expression.raised(to: 3))
    public static let electricFieldStrength = Self(name: "electric field strength", unit: SI.Unit.Name.volt.expression / SI.Unit.Name.metre.expression)
    public static let chargeDensity = Self(name: "electric charge density", unit: SI.Unit.Name.coulomb.expression / SI.Unit.Name.metre.expression.raised(to: 3))
    public static let surfaceChargeDensity = Self(name: "surface charge density", unit: SI.Unit.Name.coulomb.expression / SI.Unit.Name.metre.expression.raised(to: 2))
    public static let electricFluxDensity = Self(name: "electric flux density", unit: SI.Unit.Name.coulomb.expression / SI.Unit.Name.metre.expression.raised(to: 2))
    public static let permittivity = Self(name: "permittivity", unit: SI.Unit.Name.farad.expression / SI.Unit.Name.metre.expression)
    public static let permeability = Self(name: "permeability", unit: SI.Unit.Name.henry.expression / SI.Unit.Name.metre.expression)
    public static let molarEnergy = Self(name: "molar energy", unit: SI.Unit.Name.joule.expression / SI.Unit.Name.mole.expression)
    public static let molarEntropy = Self(name: "molar entropy", unit: SI.Unit.Name.joule.expression / SI.Unit.Name.mole.expression / SI.Unit.Name.kelvin.expression)
    public static let molarHeatCapacity = Self(name: "molar heat capacity", unit: SI.Unit.Name.joule.expression / SI.Unit.Name.mole.expression / SI.Unit.Name.kelvin.expression)
    public static let exposure = Self(name: "exposure (x- and gamma-rays)", unit: SI.Unit.Name.coulomb.expression / SI.Unit.Name.kilogram.expression)
    public static let absorbedDoseRate = Self(name: "absorbed dose rate", unit: SI.Unit.Name.gray.expression / SI.Unit.Name.second.expression)
    public static let radiantIntensity = Self(name: "radiant intensity", unit: SI.Unit.Name.watt.expression / SI.Unit.Name.steradian.expression)
    public static let radiance = Self(name: "radiance", unit: SI.Unit.Name.watt.expression / SI.Unit.Name.metre.expression.raised(to: 2) / SI.Unit.Name.steradian.expression)
    public static let catalyticConcentration = Self(name: "catalytic activity concentration", unit: SI.Unit.Name.katal.expression / SI.Unit.Name.metre.expression.raised(to: 3))
    public static let entityCount = Self(name: "number of specified entities", unit: SI.Unit.one)
    public static let refractiveIndex = Self(name: "refractive index", unit: SI.Unit.one)
    public static let relativePermittivity = Self(name: "relative permittivity", unit: SI.Unit.one)
    public static let reactivePower = Self(name: "reactive power", unit: SI.Unit.Name.volt.expression * SI.Unit.Name.ampere.expression)
    public static let brochure: [Self] = [
        .time,
        .length,
        .mass,
        .electricCurrent,
        .thermodynamicTemperature,
        .amountOfSubstance,
        .luminousIntensity,
        .planeAngle,
        .phaseAngle,
        .solidAngle,
        .frequency,
        .force,
        .pressure,
        .stress,
        .energy,
        .work,
        .heat,
        .power,
        .radiantFlux,
        .electricCharge,
        .potentialDifference,
        .capacitance,
        .resistance,
        .conductance,
        .magneticFlux,
        .magneticFluxDensity,
        .inductance,
        .celsiusTemperature,
        .temperatureInterval,
        .luminousFlux,
        .illuminance,
        .activity,
        .absorbedDose,
        .kerma,
        .doseEquivalent,
        .catalyticActivity,
        .area,
        .volume,
        .speed,
        .velocity,
        .acceleration,
        .wavenumber,
        .density,
        .surfaceDensity,
        .specificVolume,
        .currentDensity,
        .magneticFieldStrength,
        .amountConcentration,
        .massConcentration,
        .luminance,
        .dynamicViscosity,
        .torque,
        .surfaceTension,
        .angularVelocity,
        .angularFrequency,
        .angularAcceleration,
        .heatFluxDensity,
        .irradiance,
        .heatCapacity,
        .entropy,
        .specificHeatCapacity,
        .specificEntropy,
        .specificEnergy,
        .thermalConductivity,
        .energyDensity,
        .electricFieldStrength,
        .chargeDensity,
        .surfaceChargeDensity,
        .electricFluxDensity,
        .permittivity,
        .permeability,
        .molarEnergy,
        .molarEntropy,
        .molarHeatCapacity,
        .exposure,
        .absorbedDoseRate,
        .radiantIntensity,
        .radiance,
        .catalyticConcentration,
        .entityCount,
        .refractiveIndex,
        .relativePermittivity,
        .reactivePower,
    ]
}

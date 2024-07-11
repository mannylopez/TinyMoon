// Created by manny_lopez on 6/6/24.

import Foundation

// MARK: - TinyMoon + AstronomicalConstant

extension TinyMoon {

  enum AstronomicalConstant {

    static let radians = Double.pi / 180

    /// ε Epsilon
    /// The obliquity of the ecliptic. Value at the beginning of 2000:
    static let e = 23.4397

    static let perihelion = 102.9372

    static let astronomicalUnit = 149598000.0

    static func degreesToRadians(_ degrees: Double) -> Double {
      degrees * radians
    }

    static func radiansToDegrees(_ radians: Double) -> Double {
      radians * (180 / Double.pi)
    }

    /// δ The declination shows how far the body is from the celestial equator and
    /// determines from which parts of the Earth the object can be visible.
    ///
    /// - Parameters:
    ///   - longitude: in radians
    ///   - latitude: in radians
    ///
    /// - Returns: Declination, in radians
    ///
    /// Formula based on https://aa.quae.nl/en/reken/hemelpositie.html#1_7
    /// and https://github.com/mourner/suncalc/blob/master/suncalc.js#L39
    /// and https://github.com/microsoft/AirSim/blob/main/AirLib/include/common/EarthCelestial.hpp#L125
    static func declination(longitude: Double, latitude: Double) -> Double {
      let e = AstronomicalConstant.degreesToRadians(AstronomicalConstant.e)
      return asin(sin(latitude) * cos(e) + cos(latitude) * sin(e) * sin(longitude))
    }

    /// α The right ascension shows how far the body is from the vernal equinox, as measured along the celestial equator
    ///
    /// - Parameters:
    ///   - longitude: in radians
    ///   - latitude: in radians
    ///
    /// - Returns: Right ascension, in radians
    ///
    /// Formula based on https://aa.quae.nl/en/reken/hemelpositie.html#1_7
    /// and https://github.com/mourner/suncalc/blob/master/suncalc.js#L38
    /// and https://github.com/microsoft/AirSim/blob/main/AirLib/include/common/EarthCelestial.hpp#L120
    static func rightAscension(longitude: Double, latitude: Double) -> Double {
      let e = AstronomicalConstant.degreesToRadians(AstronomicalConstant.e)
      return atan2(sin(longitude) * cos(e) - tan(latitude) * sin(e), cos(longitude))
    }

    // MARK: Moon methods

    /// Get the position of the Moon on a given Julian Day
    ///
    /// - Parameters:
    ///   - julianDay: The date in Julian Days
    ///
    /// - Returns: Tuple with δ declination (in radians), α rightAscension (in radians), and distance (in kilometers)
    ///
    /// Formula based on  https://aa.quae.nl/en/reken/hemelpositie.html#4
    /// and https://github.com/microsoft/AirSim/blob/main/AirLib/include/common/EarthCelestial.hpp#L180
    /// and https://github.com/mourner/suncalc/blob/master/suncalc.js#L186
    static func moonCoordinates(julianDay: Double) -> (declination: Double, rightAscension: Double, distance: Double) {
      let daysSinceJ2000 = daysSinceJ2000(from: julianDay)
      let L = AstronomicalConstant
        .degreesToRadians(218.316 + 13.176396 * daysSinceJ2000) // Geocentric ecliptic longitude, in radians
      let M = AstronomicalConstant
        .degreesToRadians(134.963 + 13.064993 * daysSinceJ2000) // Mean anomaly, in radians
      let F = AstronomicalConstant
        .degreesToRadians(93.272 + 13.229350 * daysSinceJ2000) // Mean distance of the Moon from its ascending node, in radians

      let longitude = L + AstronomicalConstant
        .degreesToRadians(6.289 * sin(M)) // λ Geocentric ecliptic longitude, in radians
      let latitude = AstronomicalConstant
        .degreesToRadians(5.128 * sin(F)) // φ Geocentric ecliptic latitude, in radians
      let distance = 385001 - 20905 * cos(M) // Distance to the Moon, in kilometers

      let declination = declination(longitude: longitude, latitude: latitude)
      let rightAscension = rightAscension(longitude: longitude, latitude: latitude)

      return (declination, rightAscension, distance)
    }

    /// Get Moon phase, composed of illumination, phase, and angle
    ///
    /// - Parameters:
    ///   - julianDay: The date in Julian Days
    ///
    /// - Returns: Tuple containing illuminatedFraction, phase, and angle
    ///
    /// - illuminatedFraction: Varies between `0.0` new moon and `1.0` full moon
    /// - phase: Varies between `0.0` to `0.99`. `0.0` new moon, `0.25` first quarter, `0.5` full moon, `0.75` last quarter
    ///
    /// Formula based on https://github.com/microsoft/AirSim/blob/main/AirLib/include/common/EarthCelestial.hpp#L89
    /// and https://github.com/mourner/suncalc/blob/master/suncalc.js#L230
    /// and https://github.com/wlandsman/IDLAstro/blob/master/pro/mphase.pro
    static func getMoonPhase(julianDay: Double) -> (illuminatedFraction: Double, phase: Double, angle: Double) {
      let s = sunCoordinates(julianDay: julianDay)
      let m = moonCoordinates(julianDay: julianDay)

      // Geocentric elongation of the Moon from the Sun
      let phi =
        acos(
          sin(s.declination) * sin(m.declination) + cos(s.declination) * cos(m.declination) *
            cos(s.rightAscension - m.rightAscension))
      //  Selenocentric (Moon centered) elongation of the Earth from the Sun
      let inc = atan2(astronomicalUnit * sin(phi), m.distance - astronomicalUnit * cos(phi))
      let angle = atan2(
        cos(s.declination) * sin(s.rightAscension - m.rightAscension),
        sin(s.declination) * cos(m.declination) - cos(s.declination) * sin(m.declination) *
          cos(s.rightAscension - m.rightAscension))

      let illuminatedFraction = (1 + cos(inc)) / 2
      let phase = _phase(julianDay: julianDay)

      return (illuminatedFraction, phase, angle)
    }

    // MARK: Solar methods

    /// The mean anomaly for the sun
    ///
    /// - Parameters:
    ///   - julianDay: The date in Julian Days
    ///
    /// - Returns: Mean anomaly for the sun, in radians
    ///
    /// Formula based https://aa.quae.nl/en/reken/hemelpositie.html#1_1
    /// https://github.com/microsoft/AirSim/blob/main/AirLib/include/common/EarthCelestial.hpp#L155
    /// and https://github.com/mourner/suncalc/blob/master/suncalc.js#L57
    static func solarMeanAnomaly(julianDay: Double) -> Double {
      let daysSinceJ2000 = daysSinceJ2000(from: julianDay)
      return AstronomicalConstant.degreesToRadians(357.5291 + 0.98560028 * daysSinceJ2000)
    }

    /// The ecliptic longitude λ [lambda] shows how far the celestial body is from the vernal equinox, measured along the ecliptic
    ///
    /// - Parameters:
    ///   - solarMeanAnomaly: in radians
    ///
    /// - Returns: Ecliptic longitude, in radians
    ///
    /// Formula based on https://aa.quae.nl/en/reken/hemelpositie.html#1_1
    /// and https://github.com/microsoft/AirSim/blob/main/AirLib/include/common/EarthCelestial.hpp#L160
    /// and https://github.com/mourner/suncalc/blob/master/suncalc.js#L59
    static func eclipticLongitude(solarMeanAnomaly: Double) -> Double {
      let center =
        degreesToRadians(
          1.9148 * sin(solarMeanAnomaly) + 0.02 * sin(2 * solarMeanAnomaly) + 0.0003 *
            sin(3 * solarMeanAnomaly)) // Equation of center
      let perihelionInRadians = degreesToRadians(perihelion)
      return solarMeanAnomaly + center + perihelionInRadians + Double.pi
    }

    /// Get the position of the Sun on a given Julian Day
    ///
    /// - Parameters:
    ///   - julianDay: The date in Julian Days
    ///
    /// - Returns: Tuple with δ declination (in radians) and α rightAscension (in radians)
    ///
    /// Formula from https://aa.quae.nl/en/reken/hemelpositie.html#1
    /// https://github.com/microsoft/AirSim/blob/main/AirLib/include/common/EarthCelestial.hpp#L167
    /// and https://github.com/mourner/suncalc/blob/master/suncalc.js#L67
    static func sunCoordinates(julianDay: Double) -> (declination: Double, rightAscension: Double) {
      let solarMeanAnomaly = solarMeanAnomaly(julianDay: julianDay)
      let eclipticLongitude = eclipticLongitude(solarMeanAnomaly: solarMeanAnomaly)

      let declination = declination(longitude: eclipticLongitude, latitude: 0)
      let rightAscension = rightAscension(longitude: eclipticLongitude, latitude: 0)

      return (declination, rightAscension)
    }

    // MARK: Julian day methods

    /// The number of Julian days since 1 January 2000, 12:00 UTC
    ///
    /// `2451545.0` is the Julian date on 1 January 2000, 12:00 UTC, aka J2000
    static func daysSinceJ2000(from jd: Double) -> Double {
      jd - 2451545.0
    }

    /// Calculates the Julian Day (JD) for a given Date
    ///
    /// - Parameters:
    ///   - date: Any Swift Date to calculate the Julian Day for
    ///
    /// - Returns: The Julian Day number
    ///
    /// The Julian Day Count is a uniform count of days from a remote epoch in the past and is used for calculating the days between two events.
    ///
    /// The Julian day is calculated by combining the contributions from the years, months, and day, taking into account constant
    ///
    /// Formula based on https://github.com/mourner/suncalc/blob/master/suncalc.js#L29
    /// and https://github.com/microsoft/AirSim/blob/main/AirLib/include/common/EarthCelestial.hpp#L115
    /// - Note
    ///   - `2440588` is the Julian day for January 1, 1970, 12:00 UTC, aka J1970
    ///   - `1000 * 60 * 60 * 24` is a day in milliseconds
    static func julianDay(_ date: Date) -> Double {
      (date.timeIntervalSince1970 * 1000) / (1000 * 60 * 60 * 24) - 0.5 + 2440588.0
    }
  }
}

extension TinyMoon.AstronomicalConstant {
  // Julian date on 1 January 1980, 00:00 UTC
  static let J1980 = 2444238.5

  // MARK: - Sun constants

  // Ecliptic longitude of the Sun at J1980
  static let sunEclipticLongitudeJ1980 = 278.833540
  // Ecliptic longitude of the Sun's perigee at J1980
  static let sunPerigeeEclipticLongitudeJ1989 = 282.596403
  // Eccentricity of Earth's orbit
  static let earthOrbitEccentricity = 0.016718

  // MARK: - Moon constants

  // Moon's mean longitude at J1980
  static let moonMeanLongitudeJ1980 = 64.975464
  // Longitude of the Moon's perigee at J1980
  static let moonPerigeeLongitudeJ1980 = 349.383063
  // Mean longitude of the node at J1980
  static let moonNodeLongitude1980 = 151.950429
  // Inclination of the Moon's orbit
  static let moonOrbitInclination = 5.145396
  // Semi-major axis of Moon's orbit in km
  static let moonOrbitSemiMajorAxis = 384401.0
  // Eccentricity of the Moon's orbit
  static let moonEccentricity = 0.054900


  // MARK: - Mathematical formulas

  static func fixangle(_ a: Double) -> Double {
      return a - 360.0 * floor(a / 360.0)
  }

  static func kepler(m: Double, ecc: Double) -> Double {
      var e = degreesToRadians(m)
      let mRad = degreesToRadians(m)
      var delta: Double
      let maxIterations = 1000  // Set a limit for maximum iterations
      var iteration = 0
      let epsilon = 1e-10  // Set a small threshold for convergence

      repeat {
          delta = e - ecc * sin(e) - mRad
          e -= delta / (1.0 - ecc * cos(e))
          iteration += 1
          if iteration > maxIterations {
            print("Warning: Kepler function did not converge")
            break
          }
      } while abs(delta) > epsilon

      return e
  }

  static func phase(julianDay: Double) -> Double {
      // Calculation of the Sun's position
      let jdSinceJ1980 = julianDay - J1980
      let N = fixangle((360 / 365.2422) * jdSinceJ1980)    /* Mean anomaly of the Sun */
      let M = fixangle(N + sunEclipticLongitudeJ1980 - sunPerigeeEclipticLongitudeJ1989)       /* Convert from perigee coordinates to epoch 1980.0 */
      var Ec = kepler(m: M, ecc: earthOrbitEccentricity)          /* Solve equation of Kepler */
      Ec = sqrt((1.0 + earthOrbitEccentricity) / (1.0 - earthOrbitEccentricity)) * tan(Ec / 2.0)
      Ec = 2.0 * radiansToDegrees(atan(Ec))                  /* True anomaly */
      let Lambdasun = fixangle(Ec + sunPerigeeEclipticLongitudeJ1989)       /* Sun's geocentric ecliptic longitude */

      /* Calculation of the Moon's position */

      /* Moon's mean longitude */
      let ml = fixangle(13.1763966 * jdSinceJ1980 + moonMeanLongitudeJ1980)

      /* Moon's mean anomaly */
      let MM = fixangle(ml - 0.1114041 * jdSinceJ1980 - moonPerigeeLongitudeJ1980)

      /* Evection */
      let Ev = 1.2739 * sin(degreesToRadians(2.0 * (ml - Lambdasun) - MM))

      /* Annual equation */
      let Ae = 0.1858 * sin(degreesToRadians(M))

      /* Correction term */
      let A3 = 0.37 * sin(degreesToRadians(M))

      /* Corrected anomaly */
      let MmP = MM + Ev - Ae - A3

      /* Correction for the equation of the centre */
      let mEc = 6.2886 * sin(degreesToRadians(MmP))

      /* Another correction term */
      let A4 = 0.214 * sin(degreesToRadians(2.0 * MmP))

      /* Corrected longitude */
      let lP = ml + Ev + mEc - Ae + A4

      /* Variation */
      let V = 0.6583 * sin(degreesToRadians(2.0 * (lP - Lambdasun)))

      /* True longitude */
      let lPP = lP + V

      /* Calculation of the phase of the Moon */

      /* Age of the Moon in degrees */
      let MoonAge = lPP - Lambdasun

      /* Phase of the Moon */
      // let MoonPhase = (1.0 - cos(torad(MoonAge))) / 2.0

      // return MoonPhase
      // return synmonth * (fixangle(MoonAge) / 360.0)
      return fixangle(MoonAge) / 360.0
  }

  /// Calculates the Moon's phase, represented as a fraction
  ///
  /// - Parameter:
  ///   - julianDay: The date in Julian Days
  ///
  /// - Returns: Phase as a percentage of a full circle (i.e., 0 to 1), where 0.0` new moon, `0.25` first quarter, `0.5` full moon, `0.75` last quarter
  ///
  /// Formula based on source code from https://www.fourmilab.ch/moontoolw/
  static func _phase(julianDay: Double) -> Double {
    // Julian days since 1 January 1980, 00:00 UTC
    let jdSinceJ1980 = julianDay - J1980
    // Mean anomaly of the Sun
    let N = fixangle((360 / 365.2422) * jdSinceJ1980)
    // Convert from perigee coordinates to J1980
    let M = fixangle(N + sunEclipticLongitudeJ1980 - sunPerigeeEclipticLongitudeJ1989)
    // Solve for Kepler equation
    var Ec = kepler(m: M, ecc: earthOrbitEccentricity)
    Ec = sqrt((1.0 + earthOrbitEccentricity) / (1.0 - earthOrbitEccentricity)) * tan(Ec / 2.0)
    // True anomaly
    Ec = 2.0 * radiansToDegrees(atan(Ec))
    // Sun's geocentric ecliptic longitude
    let lambdaSun = fixangle(Ec + sunPerigeeEclipticLongitudeJ1989)

    // Calculation of the Moon's position
    // Moon's mean longitude
    let moonMeanLongitude = fixangle(13.1763966 * jdSinceJ1980 + moonMeanLongitudeJ1980)
    // Moon's mean anomaly
    let moonMeanAnomaly = fixangle(moonMeanLongitude - 0.1114041 * jdSinceJ1980 - moonPerigeeLongitudeJ1980)
    // Moon's ascending node mean longitude
    let moonAscendingNodeMeanLongitude = fixangle(moonNodeLongitude1980 - 0.0529539 * jdSinceJ1980)
    // Evection
    let evection = 1.2739 * sin(degreesToRadians(2 * (moonMeanLongitude - lambdaSun) - moonMeanAnomaly))
    // Annual equation
    let annualEquation = 0.1858 * sin(degreesToRadians(M))
    // Corrected term
    let A3 = 0.37 * sin(degreesToRadians(M))
    // Corrected anomaly
    let MmP = moonMeanAnomaly + evection - annualEquation - A3
    // Correction for the equation of center
    let mEc = 6.2886 * sin(degreesToRadians(MmP))
    // Another correction term
    let A4 = 0.214 * sin(degreesToRadians(2 * MmP))
    // Corrected longitude
    let lP = moonMeanLongitude + evection + mEc - annualEquation + A4
    // Variation
    let variation = 0.6583 * sin(degreesToRadians(2 * (lP - lambdaSun)))
    // True longitude
    let lPP = lP + variation
    // Corrected longitude of the node
    let NP = moonAscendingNodeMeanLongitude - 0.16 * sin(degreesToRadians(M))
    // Y inclination coordinate
    let y = sin(degreesToRadians(lPP - NP)) * cos(degreesToRadians(moonOrbitInclination))
    // X inclination coordinate
    let x = cos(degreesToRadians(lPP - NP))
    // Ecliptic longitude
    var lambdaMoon = radiansToDegrees(atan2(y, x))
    lambdaMoon += NP
    // Ecliptic latitude
    let betaM = radiansToDegrees(asin(sin(degreesToRadians(lPP - NP)) * sin(degreesToRadians(moonOrbitInclination))))

    // Calculation of the phase of the Moon
    // Age of the Moon in degrees
    let moonAge = lPP - lambdaSun
    // Phase of the Moon
    let moonPhase = (1 - cos(degreesToRadians(moonAge))) / 2
    // Distance of moon from the center of the Earth
    let moonDistance = (moonOrbitSemiMajorAxis * (1 - moonEccentricity * moonEccentricity)) / (1 + moonEccentricity * cos(degreesToRadians(MmP + mEc)))

    // Returns the terminator phase angle as a percentage of a full circle (i.e., 0 to 1)
    let normalizedMoonPhase = fixangle(moonAge) / 360.0
    return normalizedMoonPhase
  }
}

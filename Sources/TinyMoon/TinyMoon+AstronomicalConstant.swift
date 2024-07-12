// Created by manny_lopez on 6/6/24.

import Foundation

// MARK: - TinyMoon + AstronomicalConstant

extension TinyMoon {

  enum AstronomicalConstant {

    // MARK: Internal

    /// Julian date on 1 January 1980, 00:00 UTC
    static let J1980 = 2444238.5
    /// Eccentricity of Earth's orbit
    static let earthOrbitEccentricity = 0.016718

    // MARK: - Sun constants

    /// Ecliptic longitude of the Sun at J1980
    static let sunEclipticLongitudeJ1980 = 278.833540
    /// Ecliptic longitude of the Sun's perigee at J1980
    static let sunPerigeeEclipticLongitudeJ1989 = 282.596403

    // MARK: - Moon constants

    /// Moon's mean longitude at J1980
    static let moonMeanLongitudeJ1980 = 64.975464
    /// Longitude of the Moon's perigee at J1980
    static let moonPerigeeLongitudeJ1980 = 349.383063
    /// Semi-major axis of Moon's orbit in km
    static let moonOrbitSemiMajorAxis = 384401.0
    /// Eccentricity of the Moon's orbit
    static let moonEccentricity = 0.054900
    /// Synodic month (new Moon to new Moon)
    static let synodicMonth = 29.53058868


    /// Get `MoonDetail`s for the given Julian day
    ///
    /// - Parameters:
    ///   - julianDay: The date in Julian Days
    ///
    /// - Returns: MoonDetail object with moon details for the given Julian day
    static func getMoonPhase(julianDay: Double) -> TinyMoon.MoonDetail {
      calculateMoonDetail(for: julianDay)
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

    static func degreesToRadians(_ degrees: Double) -> Double {
      degrees * (Double.pi / 180)
    }

    static func radiansToDegrees(_ radians: Double) -> Double {
      radians * (180 / Double.pi)
    }

    // MARK: Private

    /// Calculates the Moon's metadata for the given Julian day
    ///
    /// - Parameter:
    ///   - julianDay: The date in Julian Days
    ///
    /// - Returns: MoonDetail object with moon details for the given Julian day
    ///
    /// Formula based on source code from https://www.fourmilab.ch/moontoolw/
    private static func calculateMoonDetail(for julianDay: Double) -> TinyMoon.MoonDetail {
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

      // Calculation of the phase of the Moon

      // Age of the Moon in degrees
      let moonAgeInDegrees = lPP - lambdaSun
      // Age of the moon in days, minutes, hours
      let (days, hour, minutes) = convertDegreesToDaysHoursMinutes(degrees: moonAgeInDegrees)

      // Phase of the Moon, where 0 = new and 100 = full
      // AKA, illuminated fraction
      let illuminatedFraction = (1 - cos(degreesToRadians(moonAgeInDegrees))) / 2

      // Distance of moon from the center of the Earth
      let moonDistance = (moonOrbitSemiMajorAxis * (1 - moonEccentricity * moonEccentricity)) /
        (1 + moonEccentricity * cos(degreesToRadians(MmP + mEc)))

      // Moon age
      // AKA days into the cycle
      let moonAge = synodicMonth * (fixangle(moonAgeInDegrees) / 360.0)

      // Returns the terminator phase angle as a percentage of a full circle (i.e., 0 to 1)
      let moonPhaseTerminator = fixangle(moonAgeInDegrees) / 360.0

      return TinyMoon.MoonDetail(
        julianDay: julianDay,
        moonAgeinDegrees: moonAgeInDegrees,
        ageOfMoon: (days, hour, minutes),
        illuminatedFraction: illuminatedFraction,
        moonDistance: moonDistance,
        moonAge: moonAge,
        phase: moonPhaseTerminator)
    }

    private static func convertDegreesToDaysHoursMinutes(degrees: Double) -> (days: Int, hours: Int, minutes: Int) {
      let degreesPerDay = 360.0 / synodicMonth
      let totalDays = degrees / degreesPerDay

      let days = Int(totalDays)
      let fractionalDay = totalDays - Double(days)

      let totalHours = fractionalDay * 24.0
      let hours = Int(totalHours)
      let fractionalHour = totalHours - Double(hours)

      let totalMinutes = fractionalHour * 60.0
      let minutes = Int(totalMinutes)

      return (days, hours, minutes)
    }

    // MARK: - Mathematical formulas

    private static func fixangle(_ a: Double) -> Double {
      a - 360.0 * floor(a / 360.0)
    }

    private static func kepler(m: Double, ecc: Double) -> Double {
      var e = degreesToRadians(m)
      let mRad = degreesToRadians(m)
      var delta: Double
      let maxIterations = 1000 // Set a limit for maximum iterations
      var iteration = 0
      let epsilon = 1e-10 // Set a small threshold for convergence

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


  }
}


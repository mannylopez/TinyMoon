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

    /// Get Moon phase
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
      let phase = 0.5 + 0.5 * inc * (angle < 0 ? -1 : 1) / Double.pi

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
      return AstronomicalConstant.degreesToRadians(357.5291 + 0.9856002 * daysSinceJ2000)
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
    /// `2451545.0` is the Julian date on 1 January 2000, 12:00 UTC, aka J2000.0
    static func daysSinceJ2000(from jd: Double) -> Double {
      jd - 2451545.0
    }

    /// The Julian Day Count is a uniform count of days from a remote epoch in the past and is used for calculating the days between two events.
    /// The Julian day is calculated by combining the contributions from the years, months, and day, taking into account constant offsets and rounding down the result.
    /// https://quasar.as.utexas.edu/BillInfo/JulianDatesG.html
    /// - Note: This version does not use hours or minutes to compute the Julian Day, so it will only return up to one decimal point of accuracy.
    static func lessPreciseJulianDay(year: Int, month: Int, day: Int) -> Double {
      var newYear = year
      var newMonth = month
      if month <= 2 {
        newYear = year - 1
        newMonth = month + 12
      }
      let a = Int(newYear / 100)
      let b = Int(a / 4)
      let c = 2 - a + b
      let e = Int(365.25 * Double(newYear + 4716))
      let f = Int(30.6001 * Double(newMonth + 1))
      return Double(c + day + e + f) - 1524.5
    }

    /// Calculates the Julian Day (JD) for a given Date
    ///
    /// - Parameters:
    ///   - date: Any Swift Date to calculate the Julian Day for
    ///
    /// - Returns: The Julian Day number, rounded down to four decimal points
    ///
    /// The Julian Day Count is a uniform count of days from a remote epoch in the past and is used for calculating the days between two events.
    ///
    /// The Julian day is calculated by combining the contributions from the years, months, and day, taking into account constant offsets and rounding down the result.
    /// https://quasar.as.utexas.edu/BillInfo/JulianDatesG.html
    /// - Note: Uses hour, minute, and seconds to calculate a precise Julian Day
    static func julianDay(_ date: Date) -> Double {
      var calendar = Calendar.current
      calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? calendar.timeZone
      let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

      guard
        let year = components.year,
        let month = components.month,
        let day = components.day,
        let hour = components.hour,
        let minute = components.minute,
        let second = components.second
      else {
        fatalError("Could not extract date components")
      }

      /// Used to adjust January and February to be part of the previous year.
      /// `14` is used to adjust the start of the year to March. Will either be `0` or `1`.
      let a = (14 - month) / 12
      /// The Julian Day calculation sets year 0 as 4713 BC.
      /// To avoid working with negative numbers, `4800` is used as an offset.
      let y = year + 4800 - a
      /// Adjusts the month for the Julian Day calculation, where March is considered the first month of the year.
      let m = month + 12 * a - 3

      /// Calculate Julian Day Number for the date
      /// - `153`: A magic number used for month length adjustments.
      /// - `365`, `4`, `100`, and `400`: These relate to the number of days in a year and the correction for leap years in the Julian and Gregorian calendars.
      /// `32045` is the correction factor to align the result with the Julian Day Number.
      let jdn = Double(day) + Double((153 * m + 2) / 5) + Double(y) * 365 + Double(y / 4) - Double(y / 100) + Double(y / 400) -
        32045

      /// Calculate the fraction of the day past since midnight
      ///  `1440` is the number of minutes in a day, and `86400` is the number of seconds in a day
      let dayFraction = (Double(hour) - 12) / 24 + Double(minute) / 1440 + Double(second) / 86400
      let julianDayWithTime = jdn + dayFraction
      let roundedJulianDay = (julianDayWithTime * 10000).rounded() / 10000

      return roundedJulianDay
    }
  }
}

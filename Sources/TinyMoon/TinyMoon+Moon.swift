// Created by manny_lopez on 6/7/24.

import Foundation

// MARK: - TinyMoon + Moon

extension TinyMoon {

  /// The `Moon` object for a specific date, prioritizing major phases.
  ///
  /// Use this object when you need a general understanding of the moon's phase for a day, especially when emphasizing the major phases is important for your application's context.
  ///
  /// If one of the major moon phases (new moon, first quarter, full moon, last quarter) occurs at any time within the 24-hour period of the specified date, this object will reflect that major moon phase.
  ///
  /// If no major moon phase occurs within the date's 24 hours (starting at 00:00 and ending at 23:59), the object will represent the moon phase closest to the specified date and time.
  ///
  /// - Note: Unlike `ExactMoon`, this object will prioritize major moon phases occurring at any point within a 24-hour period.
  public struct Moon: Hashable {
    init(date: Date) {
      self.date = date
      let julianDay = AstronomicalConstant.julianDay(date)
      let moonPhaseData = AstronomicalConstant.getMoonPhase(julianDay: julianDay)
      self.phaseFraction = moonPhaseData.phase
      self.illuminatedFraction = moonPhaseData.illuminatedFraction
      self.moonPhase = Moon.moonPhase(julianDay: julianDay, phaseFraction: phaseFraction)
      self.name = moonPhase.rawValue
      self.emoji = moonPhase.emoji
      self.daysTillFullMoon = Moon.daysUntilFullMoon(moonPhase: moonPhase, julianDay: julianDay)
      self.daysTillNewMoon = Moon.daysUntilNewMoon(moonPhase: moonPhase, julianDay: julianDay)
    }

    /// Represents where the phase is in the current synodic cycle. Varies between `0.0` to `0.99`.
    ///
    /// `0.0` new moon, `0.25` first quarter, `0.5` full moon, `0.75` last
    public let phaseFraction: Double
    /// Illuminated fraction of Moon's disk, between `0.0` and `1.0`.
    ///
    /// `0` indicates a new moon and `1.0` indicates a full moon.
    public let illuminatedFraction: Double
    public let moonPhase: MoonPhase
    public let name: String
    public let emoji: String
    public let date: Date
    /// Returns `0` if the current `date` is a full moon
    public var daysTillFullMoon: Int
    /// Returns `0` if the current `date` is a new moon
    public var daysTillNewMoon: Int

    public func isFullMoon() -> Bool {
      switch moonPhase {
      case .fullMoon: true
      default: false
      }
    }

    public var fullMoonName: String? {
      if isFullMoon() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: date)
        if let month = components.month {
          return fullMoonName(month: month)
        }
      }
      return nil
    }

    private func fullMoonName(month: Int) -> String? {
      switch month {
      case 1: "Wolf Moon"
      case 2: "Snow Moon"
      case 3: "Worm Moon"
      case 4: "Pink Moon"
      case 5: "Flower Moon"
      case 6: "Strawberry Moon"
      case 7: "Buck Moon"
      case 8: "Sturgeon Moon"
      case 9: "Harvest Moon"
      case 10: "Hunter's Moon"
      case 11: "Beaver Moon"
      case 12: "Cold Moon"
      default: nil
      }
    }

    internal static func daysUntilFullMoon(moonPhase: MoonPhase, julianDay: Double) -> Int {
      if moonPhase == .fullMoon {
        return 0
      }
      var phase: MoonPhase = moonPhase
      var currentJulianDay = julianDay
      var daysUntilFullMoon = 0

      while phase != .fullMoon {
        if let majorMoonPhase = dayIncludesMajorMoonPhase(julianDay: currentJulianDay) {
          phase = majorMoonPhase
          currentJulianDay += 1
          daysUntilFullMoon += 1
        } else {
          currentJulianDay += 1
          daysUntilFullMoon += 1
        }
      }

      return daysUntilFullMoon - 1
    }

    internal static func daysUntilNewMoon(moonPhase: MoonPhase, julianDay: Double) -> Int {
      if moonPhase == .newMoon {
        return 0
      }
      var phase: MoonPhase = moonPhase
      var currentJulianDay = julianDay
      var daysUntilNewMoon = 0

      while phase != .newMoon {
        if let majorMoonPhase = dayIncludesMajorMoonPhase(julianDay: currentJulianDay) {
          phase = majorMoonPhase
          currentJulianDay += 1
          daysUntilNewMoon += 1
        } else {
          currentJulianDay += 1
          daysUntilNewMoon += 1
        }
      }

      return daysUntilNewMoon - 1
    }


    /// Determines the moon phase for a given Julian day, considering both major and minor moon phases.
    ///
    /// This function first checks if the specified Julian day includes one of the major moon phases (new moon, first quarter, full moon, last quarter).
    /// If a major moon phase occurs within the day, that phase is returned. Otherwise, the function calculates the minor moon phase based on the given phase fraction.
    ///
    /// - Parameters:
    ///   - julianDay: A `Double` representing the Julian day for which to determine the moon phase.
    ///   - phaseFraction: A `Double` representing the fractional part of the moon's phase, used to calculate the minor moon phase if no major moon phase occurs on the given day.
    ///
    /// - Returns: A `MoonPhase` indicating either the major moon phase occurring on the specified day or the minor moon phase calculated from the phase fraction.
    ///
    /// Example Usage:
    ///
    /// ```swift
    /// let julianDay = 2451545.0 // An example Julian day
    /// let phaseFraction = 0.1 // An example phase fraction
    /// let moonPhase = moonPhase(julianDay: julianDay, phaseFraction: phaseFraction)
    /// print(moonPhase) // Output depends on the calculated or determined moon phase
    /// ```
    internal static func moonPhase(julianDay: Double, phaseFraction: Double) -> MoonPhase {
      if let moonPhase = Moon.dayIncludesMajorMoonPhase(julianDay: julianDay) {
        return moonPhase
      } else {
        return Moon.minorMoonPhase(phaseFraction: phaseFraction)
      }
    }

    /// Checks if a given Julian day includes one of the major moon phases.
    ///
    /// This function evaluates whether the specified Julian day encompasses any of the major moon phases: new moon, first quarter, full moon, or last quarter.
    /// It does so by calculating the moon phase fraction at the start and end of the Julian day and checking if the exact point of a major moon phase falls within this range.
    ///
    /// - Parameter julianDay: A `Double` representing the Julian day to check for major moon phases.
    ///
    /// - Returns: An optional `MoonPhase` representing the major moon phase occurring on the specified day, if any. Returns `nil` if no major moon phase occurs on that day.
    ///
    /// - Note: The determination of major moon phases is based on predefined thresholds for phase fractions that correspond to the significant points in a lunar cycle
    internal static func dayIncludesMajorMoonPhase(julianDay: Double) -> MoonPhase? {
      let startAndEndOfJulianDay = startAndEndOfJulianDay(julianDay: julianDay)
      let moonPhaseFractionAtStart = AstronomicalConstant.getMoonPhase(julianDay: startAndEndOfJulianDay.start).phase
      let moonPhaseFractionAtEnd = AstronomicalConstant.getMoonPhase(julianDay: startAndEndOfJulianDay.end).phase
      return majorMoonPhaseInRange(start: moonPhaseFractionAtStart, end: moonPhaseFractionAtEnd)
    }

    /// Calculates Julian days for a 00:00 UT and 23:00 UT centered around the given Julian day.
    ///
    /// - Parameter julianDay: The Julian day around which to calculate the 24-hour period. The fractional part of this parameter determines the starting point of the period.
    ///
    /// - Returns: An array of two Julian days representing the start of the 24-hour period at 00:00 UT and the end point at 23:59 UT.
    ///
    /// Example Usage:
    ///
    /// ```swift
    /// let jd = 2460320.5 // Represents January 11, 2024 at 00:00 UT
    /// let julianDays = startAndEndOfJulianDay(julianDay: jd)
    /// print(julianDays)
    /// // Output: [2460320.5, 2460321.4993]
    /// // Where:
    /// // 2460320.5  = January 11, 2024 at 00:00 UT
    /// // 2460321.25 = January 11, 2024 at 23:59 UT
    /// ```
    internal static func startAndEndOfJulianDay(julianDay: Double) -> (start: Double, end: Double) {
      let base = floor(julianDay) + (julianDay.truncatingRemainder(dividingBy: 1) < 0.5 ? -1 : 0)
      let arr = [0.5, 1.4993].map { base + $0 }
      return (start: arr[0], end: arr[1])
    }

    /// Determines if the range between two moon phase fractions includes one of the major moon phases.
    ///
    /// This function checks a specified range of moon phase fractions to determine if it includes one of the major moon phases: new moon, first quarter, full moon, or last quarter.
    /// The moon phase cycle is considered cyclical, meaning it wraps from the end of the cycle (`0.99`) back to the start (`0.0`).
    ///
    /// - Parameters:
    ///   - start: The starting moon phase fraction of the range, where `0.0` represents a new moon and values increase towards a full cycle just before another new moon (`0.99`).
    ///   - end: The ending moon phase fraction of the range. If this value is less than `start`, the range is considered to span the end of one cycle and the beginning of the next.
    ///
    /// - Returns: The first major moon phase `.newMoon`, `.firstQuarter`, `.fullMoon`, or `.lastQuarter` found within the specified range, if any.
    /// Returns `nil` if the range does not include a major moon phase.
    ///
    /// The function accounts for the cyclical nature of moon phases, allowing for ranges that wrap around the cycle's endpoint. For example, a range from `0.95` to `0.05` includes the `.newMoon` phase at the beginning of the cycle.
    ///
    /// Example:
    ///
    /// ```swift
    /// if let moonPhase = majorMoonPhaseInRange(start: 0.2, end: 0.3) {
    ///   print(moonPhase) // Prints: firstQuarter
    /// }
    /// ```
    ///
    /// Note:
    ///
    /// This function only considers the major moon phases and does not account for the intermediate phases such as the waxing crescent or waning gibbous.
    /// The cyclical range check allows for determining phase inclusion across the end and start of the moon phase cycle.
    static func majorMoonPhaseInRange(start: Double, end: Double) -> MoonPhase? {
      let newMoon = 0.0
      let firstQuarter = 0.25
      let fullMoon = 0.5
      let lastQuarter = 0.75

      // Handle cyclical nature of moon phases
      let isCyclicalRange = start > end

      if (start <= newMoon && end >= newMoon) || (isCyclicalRange && (start <= 0.99 || end >= newMoon)) {
        return .newMoon
      } else if (firstQuarter >= start && firstQuarter <= end) {
        return .firstQuarter
      } else if (fullMoon >= start && fullMoon <= end) {
        return .fullMoon
      } else if (lastQuarter >= start && lastQuarter <= end) {
        return .lastQuarter
      } else {
        return nil
      }
    }

    internal static func minorMoonPhase(phaseFraction: Double) -> MoonPhase {
      if phaseFraction < 0.23 {
        return .waxingCrescent
      } else if phaseFraction < 0.48 {
        return .waxingGibbous
      } else if phaseFraction < 0.73 {
        return .waningGibbous
      } else if phaseFraction < 0.98 {
        return .waningCrescent
      } else {
        return .newMoon
      }
    }
  }
}

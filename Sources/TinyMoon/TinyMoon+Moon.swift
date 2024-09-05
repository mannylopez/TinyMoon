// Created by manny_lopez on 6/7/24.

import Foundation

// MARK: - TinyMoon.Moon

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

    // MARK: Lifecycle

    init(date: Date, timeZone: TimeZone = TimeZone.current) {
      self.date = date
      self.timeZone = timeZone
      julianDay = AstronomicalConstant.julianDay(date)
      let moonDetail = AstronomicalConstant.getMoonPhase(julianDay: julianDay)
      daysElapsedInCycle = moonDetail.daysElapsedInCycle
      phaseFraction = moonDetail.phase
      ageOfMoon = moonDetail.ageOfMoon
      illuminatedFraction = moonDetail.illuminatedFraction
      distanceFromCenterOfEarth = moonDetail.distanceFromCenterOfEarth

      moonPhase = Moon.moonPhase(phaseFraction: phaseFraction, date: date, timeZone: timeZone)

      name = moonPhase.rawValue
      emoji = moonPhase.emoji
      daysTillFullMoon = Moon.daysUntilFullMoon(moonPhase: moonPhase, date: date, timeZone: timeZone)
      daysTillNewMoon = Moon.daysUntilNewMoon(moonPhase: moonPhase, date: date, timeZone: timeZone)
    }

    // MARK: Public

    public let moonPhase: MoonPhase
    public let name: String
    public let emoji: String
    public let date: Date
    public let julianDay: Double
    /// Returns `0` if the current `date` is a full moon
    public var daysTillFullMoon: Int
    /// Returns `0` if the current `date` is a new moon
    public var daysTillNewMoon: Int
    /// Number of days elapsed into the synodic cycle, represented as a fraction
    public let daysElapsedInCycle: Double
    /// Age of the moon in days, minutes, hours
    public let ageOfMoon: (days: Int, hours: Int, minutes: Int)
    /// Illuminated portion of the Moon, where 0.0 = new and 0.99 = full
    public let illuminatedFraction: Double
    /// Distance of moon from the center of the Earth, in kilometers
    public let distanceFromCenterOfEarth: Double
    /// Phase of the Moon, represented as a fraction
    ///
    /// Varies between `0.0` to `0.99`.
    /// `0.0` new moon,
    /// `0.25` first quarter,
    /// `0.5` full moon,
    /// `0.75` last quarter
    public let phaseFraction: Double

    public var fullMoonName: String? {
      if isFullMoon() {
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        let components = calendar.dateComponents([.month], from: date)
        if let month = components.month {
          return fullMoonName(month: month)
        }
      }
      return nil
    }

    public func isFullMoon() -> Bool {
      switch moonPhase {
      case .fullMoon: true
      default: false
      }
    }

    // MARK: Internal

    static func daysUntilFullMoon(
      moonPhase: MoonPhase,
      date: Date,
      timeZone: TimeZone = TimeZone.current)
      -> Int
    {
      if moonPhase == .fullMoon {
        return 0
      }
      var phase: MoonPhase = moonPhase
      var currentDate = date
      var daysUntilFullMoon = 0
      var calendar = Calendar.current
      calendar.timeZone = timeZone

      while phase != .fullMoon {
        if let majorMoonPhase = dayIncludesMajorMoonPhase(date: currentDate, timeZone: timeZone) {
          phase = majorMoonPhase
          daysUntilFullMoon += 1
          currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        } else {
          daysUntilFullMoon += 1
          currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
      }

      return daysUntilFullMoon - 1
    }

    static func daysUntilNewMoon(
      moonPhase: MoonPhase,
      date: Date,
      timeZone: TimeZone = TimeZone.current)
      -> Int
    {
      if moonPhase == .newMoon {
        return 0
      }
      var phase: MoonPhase = moonPhase
      var currentDate = date
      var daysUntilNewMoon = 0
      var calendar = Calendar.current
      calendar.timeZone = timeZone

      while phase != .newMoon {
        if let majorMoonPhase = dayIncludesMajorMoonPhase(date: currentDate, timeZone: timeZone) {
          phase = majorMoonPhase
          daysUntilNewMoon += 1
          currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        } else {
          daysUntilNewMoon += 1
          currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
      }

      return daysUntilNewMoon - 1
    }

    /// Determines the moon phase for a given date, considering both major and minor moon phases.
    ///
    /// This function first checks if the specified date includes one of the major moon phases (new moon, first quarter, full moon, last quarter) within it's 24 hours.
    /// If a major moon phase occurs within the day, that phase is returned. Otherwise, the function calculates the minor moon phase based on the given phase fraction.
    ///
    /// - Parameters:
    ///   - phaseFraction: A `Double` representing the fractional part of the moon's phase, used to calculate the minor moon phase if no major moon phase occurs on the given day.
    ///   - date: The day for which to determine the moon phase.
    ///   - timeZone: The timezone to use when calculating the date. Defaults to the system's current timezone.
    ///
    /// - Returns: A `MoonPhase` indicating either the major moon phase occurring on the specified day or the minor moon phase calculated from the phase fraction.
    ///
    /// Example Usage:
    ///
    /// ```swift
    /// let phaseFraction = 0.1 // An example phase fraction
    /// let utcTimeZone = TimeZone(identifier: "UTC")!
    /// let moonPhase = moonPhase(phaseFraction: phaseFraction, date: Date(), timeZone: utcTimeZone)
    /// print(moonPhase) // Output depends on the calculated or determined moon phase
    /// ```
    static func moonPhase(
      phaseFraction: Double,
      date: Date,
      timeZone: TimeZone = TimeZone.current)
      -> MoonPhase
    {
      if let moonPhase = Moon.dayIncludesMajorMoonPhase(date: date, timeZone: timeZone) {
        moonPhase
      } else {
        Moon.minorMoonPhase(phaseFraction: phaseFraction)
      }
    }

    /// Checks if a given date includes one of the major moon phases.
    ///
    /// This function evaluates whether the specified date encompasses any of the major moon phases: new moon, first quarter, full moon, or last quarter.
    /// It does so by calculating the moon phase fraction at the start and end of the day and checking if the exact point of a major moon phase falls within this range.
    ///
    /// - Parameters:
    ///   - date: Day to check for major moon phases.
    ///   - timeZone: The timezone to use when calculating the date. Defaults to the system's current timezone.
    ///
    /// - Returns: An optional `MoonPhase` representing the major moon phase occurring on the specified day, if any. Returns `nil` if no major moon phase occurs on that day.
    ///
    /// - Note: The determination of major moon phases is based on predefined thresholds for phase fractions that correspond to the significant points in a lunar cycle
    static func dayIncludesMajorMoonPhase(
      date: Date,
      timeZone: TimeZone = TimeZone.current)
      -> MoonPhase?
    {
      let (startJulianDay, endJulianDay) = julianStartAndEndOfDay(date: date, timeZone: timeZone)
      let moonPhaseFractionAtStart = AstronomicalConstant.getMoonPhase(julianDay: startJulianDay).phase
      let moonPhaseFractionAtEnd = AstronomicalConstant.getMoonPhase(julianDay: endJulianDay).phase
      return majorMoonPhaseInRange(start: moonPhaseFractionAtStart, end: moonPhaseFractionAtEnd)
    }

    /// Calculates Julian day values for the beginning of the day, 00:00, and 24 hours from there, representing a day's full Julian value range.
    ///
    /// - Parameters:
    ///   - date: The date around which to calculate the 24-hour period.
    ///   - timeZone: The timezone to use when calculating the date. Defaults to the system's current timezone.
    ///
    /// - Returns: A tuple of two Julian days representing the start of the 24-hour period at 00:00 and the end point at 00:00 the next day.
    ///
    /// Example Usage:
    ///
    /// ```swift
    /// let date = Date()
    /// let utcTimeZone = TimeZone(identifier: "UTC")!
    /// let (start, end) = julianStartAndEndOfDay(date: date, timeZone: utcTimeZone)
    /// print(start)
    /// // 2460586.5  = October 3, 2024 at 00:00 UTC
    /// print(end)
    /// // 2460587.5 = October 4, 2024 at 00:00 UTC
    /// ```
    static func julianStartAndEndOfDay(date: Date, timeZone: TimeZone = TimeZone.current) -> (start: Double, end: Double) {
      var calendar = Calendar.current
      calendar.timeZone = timeZone
      let startOfDay = calendar.startOfDay(for: date)
      let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)
      let startJulianDay = AstronomicalConstant.julianDay(startOfDay)
      let endJulianDay = AstronomicalConstant.julianDay(endOfDay!)
      return (start: startJulianDay, end: endJulianDay)
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
      } else if firstQuarter >= start, firstQuarter <= end {
        return .firstQuarter
      } else if fullMoon >= start, fullMoon <= end {
        return .fullMoon
      } else if lastQuarter >= start, lastQuarter <= end {
        return .lastQuarter
      } else {
        return nil
      }
    }

    static func minorMoonPhase(phaseFraction: Double) -> MoonPhase {
      if phaseFraction < 0.25 {
        .waxingCrescent
      } else if phaseFraction < 0.50 {
        .waxingGibbous
      } else if phaseFraction < 0.75 {
        .waningGibbous
      } else {
        .waningCrescent
      }
    }

    // MARK: Private

    private let timeZone: TimeZone

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

  }
}

// MARK: - TinyMoon.Moon + Equatable

extension TinyMoon.Moon: Equatable {
  public static func ==(lhs: TinyMoon.Moon, rhs: TinyMoon.Moon) -> Bool {
    lhs.julianDay == rhs.julianDay
      && lhs.daysElapsedInCycle == rhs.daysElapsedInCycle
      && lhs.ageOfMoon.days == rhs.ageOfMoon.days
      && lhs.ageOfMoon.hours == rhs.ageOfMoon.hours
      && lhs.ageOfMoon.minutes == rhs.ageOfMoon.minutes
      && lhs.illuminatedFraction == rhs.illuminatedFraction
      && lhs.distanceFromCenterOfEarth == rhs.distanceFromCenterOfEarth
      && lhs.phaseFraction == rhs.phaseFraction
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(julianDay)
    hasher.combine(daysElapsedInCycle)
    hasher.combine(ageOfMoon.days)
    hasher.combine(ageOfMoon.hours)
    hasher.combine(ageOfMoon.minutes)
    hasher.combine(illuminatedFraction)
    hasher.combine(distanceFromCenterOfEarth)
    hasher.combine(phaseFraction)
  }
}

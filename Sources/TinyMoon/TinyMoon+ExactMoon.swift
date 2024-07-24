// Created by manny_lopez on 6/7/24.

import Foundation

// MARK: - TinyMoon.ExactMoon

extension TinyMoon {

  /// The `ExactMoon` object for a specific date and time.
  ///
  /// This object represents the precise moon phase for a given date and time, without prioritizing major moon phases (new moon, first quarter, full moon, last quarter)  over others. It provides a more detailed and accurate representation of the moon's phase, suitable for applications requiring precise lunar data.
  ///
  /// `ExactMoon` focuses on the exact lunar phase at the given moment, unlike `Moon`, which may prioritize major moon phases occurring at any point within a 24-hour period.
  ///
  /// For example, given that the full moon occurs on `August 19, 2024 at 13:25 UTC` and the date we query for is `August 19, 2024 at 00:00 UTC`, this object will return `.waxingGibbous` because that is a more accurate representation of the moon phase at `00:00 UTC` time. `Moon` would return `.fullMoon` since a Full Moon happens during that day.
  public struct ExactMoon: Hashable {

    // MARK: Lifecycle

    init(date: Date) {
      self.date = date
      julianDay = AstronomicalConstant.julianDay(date)
      let moonDetail = AstronomicalConstant.getMoonPhase(julianDay: julianDay)
      daysElapsedInCycle = moonDetail.daysElapsedInCycle
      ageOfMoon = moonDetail.ageOfMoon
      illuminatedFraction = moonDetail.illuminatedFraction
      distanceFromCenterOfEarth = moonDetail.distanceFromCenterOfEarth
      phaseFraction = moonDetail.phase

      moonPhase = ExactMoon.exactMoonPhase(phaseFraction: phaseFraction)

      name = moonPhase.rawValue
      emoji = moonPhase.emoji
    }

    // MARK: Public

    public let moonPhase: MoonPhase
    public let name: String
    public let emoji: String
    public let date: Date
    public let julianDay: Double
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

    // MARK: Internal

    static func exactMoonPhase(phaseFraction: Double) -> MoonPhase {
      if phaseFraction < 0.02 {
        .newMoon
      } else if phaseFraction < 0.23 {
        .waxingCrescent
      } else if phaseFraction < 0.27 {
        .firstQuarter
      } else if phaseFraction < 0.48 {
        .waxingGibbous
      } else if phaseFraction < 0.52 {
        .fullMoon
      } else if phaseFraction < 0.73 {
        .waningGibbous
      } else if phaseFraction < 0.77 {
        .lastQuarter
      } else if phaseFraction < 0.98 {
        .waningCrescent
      } else {
        .newMoon
      }
    }
  }
}

extension TinyMoon.ExactMoon {
  public static func == (lhs: TinyMoon.ExactMoon, rhs: TinyMoon.ExactMoon) -> Bool {
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

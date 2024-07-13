// Created by manny_lopez on 7/12/24.

import Foundation

// MARK: - TinyMoon + MoonDetail

extension TinyMoon {

  public struct MoonDetail: Hashable {

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
    public let phase: Double

    public static func == (lhs: TinyMoon.MoonDetail, rhs: TinyMoon.MoonDetail) -> Bool {
      lhs.julianDay == rhs.julianDay &&
        lhs.daysElapsedInCycle == rhs.daysElapsedInCycle &&
        lhs.ageOfMoon.days == rhs.ageOfMoon.days &&
        lhs.ageOfMoon.hours == rhs.ageOfMoon.hours &&
        lhs.ageOfMoon.minutes == rhs.ageOfMoon.minutes &&
        lhs.illuminatedFraction == rhs.illuminatedFraction &&
        lhs.distanceFromCenterOfEarth == rhs.distanceFromCenterOfEarth &&
        lhs.phase == rhs.phase
    }

    public func hash(into hasher: inout Hasher) {
      hasher.combine(julianDay)
      hasher.combine(daysElapsedInCycle)
      hasher.combine(ageOfMoon.days)
      hasher.combine(ageOfMoon.hours)
      hasher.combine(ageOfMoon.minutes)
      hasher.combine(illuminatedFraction)
      hasher.combine(distanceFromCenterOfEarth)
      hasher.combine(phase)
    }

  }
}

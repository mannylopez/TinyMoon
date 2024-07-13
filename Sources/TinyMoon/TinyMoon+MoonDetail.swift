// Created by manny_lopez on 7/12/24.

import Foundation

// MARK: - TinyMoon + MoonDetail

extension TinyMoon {

  struct MoonDetail {
    let julianDay: Double
    /// Number of days elapsed into the synodic cycle, represented as a fraction
    let daysElapsedInCycle: Double
    /// Age of the moon in days, minutes, hours
    let ageOfMoon: (days: Int, hours: Int, minutes: Int)
    /// Illuminated portion of the Moon, where 0.0 = new and 0.99 = full
    let illuminatedFraction: Double
    /// Distance of moon from the center of the Earth, in kilometers
    let distanceFromCenterOfEarth: Double
    /// Phase of the Moon, represented as a fraction
    ///
    /// Varies between `0.0` to `0.99`.
    /// `0.0` new moon,
    /// `0.25` first quarter,
    /// `0.5` full moon,
    /// `0.75` last quarter
    let phase: Double
  }
}

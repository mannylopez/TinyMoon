// Created by manny_lopez on 7/12/24.

import Foundation

// MARK: - TinyMoon + MoonDetail

extension TinyMoon {

  struct MoonDetail {
    let julianDay: Double
    /// Age of the Moon in degrees
    let moonAgeinDegrees: Double
    /// Age of the moon in days, minutes, hours
    let ageOfMoon: (days: Int, hours: Int, minutes: Int)
    /// Illuminated portion of the Moon, where 0 = new and 100 = full
    let illuminatedFraction: Double
    /// Distance of moon from the center of the Earth
    let moonDistance: Double
    /// Number of days elapsed into the synodic cycle
    let moonAge: Double
    /// Phase angle as a percentage of a full circle (i.e., 0 to 1).
    /// Varies between `0.0` to `0.99`. `0.0` new moon, `0.25` first quarter, `0.5` full moon, `0.75` last quarter
    let phase: Double
  }
}

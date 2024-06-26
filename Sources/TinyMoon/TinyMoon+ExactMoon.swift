// Created by manny_lopez on 6/7/24.

import Foundation

// MARK: - TinyMoon + ExactMoon

extension TinyMoon {

  /// The `ExactMoon` object for a specific date and time.
  ///
  /// This object represents the precise moon phase for a given date and time, without prioritizing major moon phases (new moon, first quarter, full moon, last quarter)  over others. It provides a more detailed and accurate representation of the moon's phase, suitable for applications requiring precise lunar data.
  ///
  /// Use `exactMoonPhase` when the specificity of the lunar phase is critical to your application, such as in astronomical apps or detailed lunar tracking that rely on precise moon phase calculations.
  ///
  /// - Note: Unlike `moonPhase`, which may prioritize major moon phases occurring at any point within a 24-hour period, `exactMoonPhase` focuses on the exact lunar phase at the given moment.
  ///
  /// For example, given that the full moon occurs on `August 19, 2024 at 13:25 UTC` and the date we query for is `August 19, 2024 at 00:00 UTC`, this object will return `.waxingGibbous` because that is a more accurate representation of the moon phase at `00:00 UTC` time.
  public struct ExactMoon: Hashable {

    // MARK: Lifecycle

    init(date: Date, phaseFraction: Double) {
      self.date = date
      exactMoonPhase = ExactMoon.exactMoonPhase(phaseFraction: phaseFraction)
      exactName = exactMoonPhase.rawValue
      exactEmoji = exactMoonPhase.emoji
    }

    // MARK: Public

    public let exactMoonPhase: MoonPhase
    public let exactName: String
    public let exactEmoji: String
    public let date: Date

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

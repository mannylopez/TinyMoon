import Foundation

public enum TinyMoon {

  /// The `Moon` object for a specific date, prioritizing major phases (new moon, first quarter, full moon, last quarter) .
  ///
  /// Use this object when you need a general understanding of the moon's phase for a day, especially when emphasizing the major phases is important for your application's context.
  ///
  /// If one of the major moon phases (new moon, first quarter, full moon, last quarter) occurs at any time within the 24-hour period of the specified date, this object will reflect that major moon phase.
  ///
  /// If no major moon phase occurs within the date's 24 hours (starting at 00:00 and ending at 23:59), the object will represent the moon phase closest to the specified date and time.
  ///
  /// - Note: Unlike `ExactMoon`, this object will prioritize major moon phases occurring at any point within a 24-hour period.
  public static func calculateMoonPhase(_ date: Date = Date(), timeZone: TimeZone = TimeZone.current) -> Moon {
    Moon(date: date, timeZone: timeZone)
  }

  /// The `ExactMoon` object for a specific date and time.
  ///
  /// This object represents the precise moon phase for a given date and time, without prioritizing major moon phases (new moon, first quarter, full moon, last quarter)  over others. It provides a more detailed and accurate representation of the moon's phase, suitable for applications requiring precise lunar data.
  ///
  /// `ExactMoon` focuses on the exact lunar phase at the given moment, unlike `Moon`, which may prioritize major moon phases occurring at any point within a 24-hour period.
  ///
  /// For example, given that the full moon occurs on `August 19, 2024 at 13:25 UTC` and the date we query for is `August 19, 2024 at 00:00 UTC`, this object will return `.waxingGibbous` because that is a more accurate representation of the moon phase at `00:00 UTC` time. `Moon` would return `.fullMoon` since a Full Moon happens during that day.
  public static func calculateExactMoonPhase(_ date: Date = Date()) -> ExactMoon {
    ExactMoon(date: date)
  }

}

import Foundation

public enum TinyMoon {

  private static var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    formatter.timeZone = TimeZone(identifier: "UTC")
    return formatter
  }

  static func formatDate(
    year: Int,
    month: Int,
    day: Int,
    hour: Int = 00,
    minute: Int = 00) -> Date
  {
    guard let date = TinyMoon.dateFormatter.date(from: "\(year)/\(month)/\(day) \(hour):\(minute)") else {
      fatalError("Invalid date")
    }
    return date
  }

  /// The `Moon` object for a specific date, prioritizing major phases (new moon, first quarter, full moon, last quarter) .
  ///
  /// Use this object when you need a general understanding of the moon's phase for a day, especially when emphasizing the major phases is important for your application's context.
  ///
  /// If one of the major moon phases (new moon, first quarter, full moon, last quarter) occurs at any time within the 24-hour period of the specified date, this object will reflect that major moon phase.
  ///
  /// If no major moon phase occurs within the date's 24 hours (starting at 00:00 and ending at 23:59), the object will represent the moon phase closest to the specified date and time.
  ///
  /// - Note: Unlike `ExactMoon`, this object will prioritize major moon phases occurring at any point within a 24-hour period.
  public static func calculateMoonPhase(_ date: Date = Date()) -> Moon {
    Moon(date: date)
  }

  /// The `ExactMoon` object for a specific date and time.
  ///
  /// This object represents the precise moon phase for a given date and time, without prioritizing major moon phases (new moon, first quarter, full moon, last quarter)  over others. It provides a more detailed and accurate representation of the moon's phase, suitable for applications requiring precise lunar data.
  ///
  /// Use `exactMoonPhase` when the specificity of the lunar phase is critical to your application, such as in astronomical apps or detailed lunar tracking that rely on precise moon phase calculations.
  ///
  /// - Note: Unlike `moonPhase`, which may prioritize major moon phases occurring at any point within a 24-hour period, `exactMoonPhase` focuses on the exact lunar phase at the given moment.
  ///
  /// For example, given that the full moon occurs on `August 19, 2024 at 13:25 UTC` and the date we query for is `August 19, 2024 at 00:00 UTC`, this object will return `.waxingGibbous` because that is a more accurate representation of the moon phase at `00:00 UTC` time.
  public static func calculateExactMoonPhase(_ date: Date = Date()) -> ExactMoon {
    let moon = Moon(date: date)
    return ExactMoon(date: date, phaseFraction: moon.phaseFraction)
  }
}

// Created by manny_lopez on 5/24/24.

import Foundation
@testable import TinyMoon

// MARK: - MoonTestHelper

enum MoonTestHelper {
  static let utcTimeZone = TimeZone(identifier: "UTC")!

  /// Helper function to return a moon object for a given Date
  static func moonObjectForDay(
    year: Int,
    month: Int,
    day: Int,
    hour: Int = 0,
    minute: Int = 0,
    timeZone: TimeZone = utcTimeZone)
    -> TinyMoon.Moon
  {
    let date = TimeTestHelper.formatDate(year: year, month: month, day: day, hour: hour, minute: minute, timeZone: timeZone)
    return TinyMoon.calculateMoonPhase(date, timeZone: timeZone)
  }

  /// Helper function to return an array of moon objects for a given range of Dates
  static func moonObjectsForRange(
    year: Int,
    month: Int,
    days: ClosedRange<Int>,
    timeZone: TimeZone = utcTimeZone)
    -> [TinyMoon.Moon]
  {
    var moons: [TinyMoon.Moon] = []

    moons = days.map { day in
      moonObjectForDay(year: year, month: month, day: day, timeZone: timeZone)
    }

    return moons
  }

  /// Helper function to return a full month's moon objects
  static func moonObjectsForMonth(
    month: MonthTestHelper.Month,
    year: Int,
    timeZone: TimeZone = utcTimeZone)
    -> [TinyMoon.Moon]
  {
    var moons: [TinyMoon.Moon] = []

    MonthTestHelper.dayRangeInMonth(month, year: year)?.forEach { day in
      moons.append(moonObjectForDay(year: year, month: month.rawValue, day: day, timeZone: timeZone))
    }

    return moons
  }

}

// MARK: - MoonTestHelper + Pretty print for debugging convenience methods

extension MoonTestHelper {
  static func prettyPrintMoonCalendar(month: MonthTestHelper.Month, year: Int, timeZone: TimeZone = utcTimeZone) {
    var calendar = Calendar.current
    calendar.timeZone = timeZone
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    // Find the first day of the month
    guard let firstDayOfMonth = dateFormatter.date(from: "\(year)-\(month.rawValue)-01") else {
      fatalError("Invalid month/year combination")
    }

    // Get the weekday of the first day of the month
    let weekday = calendar.component(.weekday, from: firstDayOfMonth)

    // Get the total number of days in the month
    guard let totalDays = MonthTestHelper.dayRangeInMonth(month, year: year) else {
      fatalError("Failed to get days in month")
    }

    // Prepare an array to hold all moon objects for the month
    let moonObjects = moonObjectsForMonth(month: month, year: year, timeZone: timeZone)

    // Calculate padding for the start of the month
    let padding = weekday - 1 // Calendar component weekday starts at 1 for Sunday

    // Adjust each row to accommodate spacing for padding
    var dayCounter = 0 - padding + 1 // Start counter to correctly place the first day of the month

    // Print the calendar header
    print(month, year)
    print("S    M     T      W     T     F     S")

    for _ in 0..<6 { // Assuming a maximum of 5 rows to cover all days of the month
      var weekString = ""
      for _ in 0..<7 {
        if dayCounter <= 0 || dayCounter > totalDays.count {
          weekString += "      " // Empty days either before the start or after the end of the month
        } else {
          let moon = moonObjects[dayCounter-1] // -1 because arrays are zero-indexed
          switch moon.moonPhase {
          case .newMoon, .firstQuarter, .fullMoon, .lastQuarter:
            weekString += " *" + moon.emoji + " |"
          default:
            weekString += String(format: "%02d", dayCounter) + moon.emoji + " |"
          }
        }
        dayCounter += 1
      }
      print(weekString)
    }
  }

  /// Pretty prints a Moon object, useful for debugging
  /// Example:
  /// ```swift
  /// let date = TestHelper.formatDate(year: 2024, month: 06, day: 7)
  /// let moon = TinyMoon.Moon(date: date)
  /// TestHelper.prettyPrintMoonObject(moon)
  /// ```
  /// Returns
  /// ```
  /// ...
  /// 2024-06-07 07:00:00 +0000
  ///     🌑 newMoon
  ///     - lunarDay: 0.7625128604803247
  ///     - maxLunarDay: 28.762512860479735
  ///     - daysTillFullMoon: 14
  ///     - daysTillNewMoon: 0
  /// ```
  static func prettyPrintMoonObject(_ moon: TinyMoon.Moon) {
    var title = ""
    switch moon.moonPhase {
    case .newMoon, .firstQuarter, .fullMoon, .lastQuarter:
      title = "\(moon.emoji) \(moon.moonPhase)"
    default:
      title = "\(moon.moonPhase) \(moon.emoji) "
    }
    let prettyString = """
      ...
      \(moon.date)
        \(title)
        - phaseFraction: \(moon.phaseFraction)
        - illuminatedFraction: \(moon.illuminatedFraction)
        - daysTillFullMoon: \(moon.daysTillFullMoon)
        - daysTillNewMoon: \(moon.daysTillNewMoon)
      """
    print(prettyString)
  }

  /// Prints the 4 major phases for each month in a given year
  /// Example output for 2024
  /// ```
  /// // January
  /// 🌗 2024-01-03 08:00:00 +0000 lastQuarter
  /// 🌑 2024-01-11 08:00:00 +0000 newMoon
  /// 🌓 2024-01-17 08:00:00 +0000 firstQuarter
  /// 🌕 2024-01-25 08:00:00 +0000 fullMoon
  /// ...
  /// // December
  /// 🌑 2024-12-01 08:00:00 +0000 newMoon
  /// 🌓 2024-12-07 08:00:00 +0000 firstQuarter
  /// 🌗 2024-12-22 08:00:00 +0000 lastQuarter
  /// 🌑 2024-12-30 08:00:00 +0000 newMoon
  /// ```
  static func prettyPrintMoonPhasesForYear(_ year: Int) {
    let moonsInYear = MonthTestHelper.Month.allCases.map { month in
      MoonTestHelper.moonObjectsForMonth(month: month, year: year)
    }

    for month in moonsInYear {
      for moon in month {
        switch moon.moonPhase {
        case .newMoon, .firstQuarter, .fullMoon, .lastQuarter:
          print(moon.emoji, moon.date, moon.moonPhase)
        default:
          continue
        }
      }
    }
  }

  /// Prints a calendar view for each month in a given year
  /// Example output for 2024
  /// ```
  /// january 2024
  /// S    M     T      W     T     F     S
  ///       01🌖 |02🌖 | *🌗 |04🌘 |05🌘 |06🌘 |
  /// 07🌘 |08🌘 |09🌘 |10🌘 | *🌑 |12🌒 |13🌒 |
  /// 14🌒 |15🌒 |16🌒 | *🌓 |18🌔 |19🌔 |20🌔 |
  /// 21🌔 |22🌔 |23🌔 |24🌔 | *🌕 |26🌖 |27🌖 |
  /// 28🌖 |29🌖 |30🌖 |31🌖 |
  /// ...
  /// december 2024
  /// S    M     T      W     T     F     S
  /// *🌑 |02🌒 |03🌒 |04🌒 |05🌒 |06🌒 | *🌓 |
  /// 08🌔 |09🌔 |10🌔 |11🌔 |12🌔 |13🌔 |14🌔 |
  /// *🌕 |16🌖 |17🌖 |18🌖 |19🌖 |20🌖 |21🌖 |
  /// *🌗 |23🌘 |24🌘 |25🌘 |26🌘 |27🌘 |28🌘 |
  /// 29🌘 | *🌑 |31🌒 |
  /// ```
  static func prettyPrintCalendarForYear(_ year: Int, timeZone: TimeZone = utcTimeZone) {
    for month in MonthTestHelper.Month.allCases {
      MoonTestHelper.prettyPrintMoonCalendar(month: month, year: year, timeZone: timeZone)
    }
  }

  /// Prints the moon object for the month in a given year
  ///
  /// Example output for January 2024
  /// ```
  /// 2024-01-01 00:00:00 +0000
  ///   waningGibbous 🌖
  ///   - phaseFraction: 0.6576253724545426
  ///   - illuminatedFraction: 0.7741821250997368
  ///   - daysTillFullMoon: 24
  ///   - daysTillNewMoon: 10
  ///
  /// ... Days 2 through 28
  ///
  /// 2024-01-29 00:00:00 +0000
  ///   waningGibbous 🌖
  ///   - phaseFraction: 0.6016526631224938
  ///   - illuminatedFraction: 0.9014349660199269
  ///   - daysTillFullMoon: 26
  ///   - daysTillNewMoon: 11
  static func prettyPrintMoonObjectsForMonth(month: MonthTestHelper.Month, year: Int, timeZone: TimeZone = utcTimeZone) {
    let moons = moonObjectsForMonth(month: month, year: year, timeZone: timeZone)
    for moon in moons {
      MoonTestHelper.prettyPrintMoonObject(moon)
    }
  }
}

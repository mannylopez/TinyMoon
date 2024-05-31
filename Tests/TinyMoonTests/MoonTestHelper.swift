// Created by manny_lopez on 5/24/24.

import Foundation
@testable import TinyMoon

enum MoonTestHelper {
  private static var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    return formatter
  }

  static func formatDate(year: Int, month: Int, day: Int) -> Date {
    guard let date = MoonTestHelper.dateFormatter.date(from: "\(year)/\(month)/\(day) 00:00") else {
      fatalError("Invalid date")
    }
    return date
  }

  /// Helper function to return a moon object for a given Date
  static func moonDay(year: Int, month: Int, day: Int) -> TinyMoon.Moon {
    let date = MoonTestHelper.formatDate(year: year, month: month, day: day)
    let moon = TinyMoon.calculateMoonPhase(date)
    return moon
  }

  /// Helper function to return an array of moon objects for a given range of Dates
  static func moonRange(year: Int, month: Int, days: ClosedRange<Int>) -> [TinyMoon.Moon] {
    var moons: [TinyMoon.Moon] = []

    moons = days.map({ day in
      moonDay(year: year, month: month, day: day)
    })

    return moons
  }

  /// Helper function to return a full month's moon objects
  static func moonMonth(month: MonthTestHelper.Month, year: Int) -> [TinyMoon.Moon] {
    var moons: [TinyMoon.Moon] = []

    MonthTestHelper.dayRangeInMonth(month, year: year)?.forEach({ day in
      moons.append(moonDay(year: year, month: month.rawValue, day: day))
    })

    return moons
  }

}

// MARK: - TestHelper + Pretty Print Helpers

extension MoonTestHelper {
  static func printMoonCalendar(month: MonthTestHelper.Month, year: Int) {
    let calendar = Calendar.current
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
    let moonObjects = moonMonth(month: month, year: year)

    // Calculate padding for the start of the month
    let padding = weekday - 1  // Calendar component weekday starts at 1 for Sunday

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
      - lunarDay: \(moon.lunarDay)
      - maxLunarDay: \(moon.maxLunarDay)
      - daysTillFullMoon: \(moon.daysTillFullMoon)
      - daysTillNewMoon: \(moon.daysTillNewMoon)
    """
    print(prettyString)
  }
}

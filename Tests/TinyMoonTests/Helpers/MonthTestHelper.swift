// Created by manny_lopez on 5/31/24.

import Foundation

enum MonthTestHelper {
  enum Month: Int, CaseIterable {
    case january = 1
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december
  }

  /// Returns the number of calendar days in every month for the given year
  static func dayRangeInMonthForCalendarYear(_ year: Int) -> [Month: Range<Int>] {
    var yearDict = [Month: Range<Int>]()
    Month.allCases.forEach { month in
      if let days = dayRangeInMonth(month, year: year) {
        yearDict[month] = days
      }
    }
    return yearDict
  }

  /// Returns the number of calendar days in a given month
  static func dayRangeInMonth(_ month: Month, year: Int) -> Range<Int>? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM"

    if let date = dateFormatter.date(from: "\(year)-\(month.rawValue)") {
      let calendar = Calendar.current
      if let range = calendar.range(of: .day, in: .month, for: date) {
        return range
      }
    }
    return nil
  }
}

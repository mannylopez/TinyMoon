// Created by manny_lopez on 7/22/24.

import Foundation

enum TimeTestHelper {

  enum TimeZoneOption {
    case utc
    case pacific
    case tokyo

    static func createTimeZone(timeZone: TimeZoneOption) -> TimeZone {
      switch timeZone {
      case .utc:
        TimeZone(identifier: "UTC")!
      case .pacific:
        TimeZone(identifier: "America/Los_Angeles")!
      case .tokyo:
        TimeZone(identifier: "Asia/Tokyo")!
      }
    }
  }

  /// Creates a Date from the given arguments. Default is in UTC timezone.
  static func formatDate(
    year: Int,
    month: Int,
    day: Int,
    hour: Int = 00,
    minute: Int = 00,
    second: Int = 00,
    timeZone: TimeZone = TimeZoneOption.createTimeZone(timeZone: .utc))
    -> Date
  {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    components.hour = hour
    components.minute = minute
    components.second = second
    components.timeZone = timeZone

    return Calendar.current.date(from: components)!
  }
}

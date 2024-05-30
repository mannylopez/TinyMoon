// Created by manny_lopez on 5/24/24.

import Foundation
@testable import TinyMoon

struct TestHelper {
  static var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    return formatter
  }

  static func prettyPrint(_ moon: TinyMoon.Moon) {
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

  static func formatDate(year: Int, month: Int, day: Int) -> Date {
    guard let date = TestHelper.dateFormatter.date(from: "\(year)/\(month)/\(day) 00:00") else {
      fatalError("Invalid date")
    }
    return date
  }

  /// Helper function to return a moon object for a given Date
  static func moonDay(year: Int, month: Int, day: Int) -> TinyMoon.Moon {
    let date = TestHelper.formatDate(year: year, month: month, day: day)
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
  static func moonMonth(month: Helper.Month) -> [TinyMoon.Moon] {
    var moons: [TinyMoon.Moon] = []

    Helper.months2024[month]?.forEach({ day in
      moons.append(moonDay(year: 2024, month: month.rawValue, day: day))
    })

    return moons
  }

}

enum Helper {
  enum Month: Int {
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

  static let months2024: [Month: ClosedRange<Int>] = [
    .january: 1...31,
    .february: 1...29, // Leap year in 2024
    .march: 1...31,
    .april: 1...30,
    .may: 1...31,
    .june: 1...30,
    .july: 1...31,
    .august: 1...30,
    .september: 1...30,
    .october: 1...31,
    .november: 1...30,
    .december: 1...31,
  ]
}

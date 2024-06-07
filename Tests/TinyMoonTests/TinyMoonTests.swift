import XCTest
@testable import TinyMoon

final class TinyMoonTests: XCTestCase {

  func test_moon_daysUntilFullMoon() {
    // Full Moon at Jun 22  01:07
    var date = TinyMoon.formatDate(year: 2024, month: 06, day: 20)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var daysTill = TinyMoon.Moon.daysUntilFullMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 2)

    // Full Moon at Sep 18  02:34
    date = TinyMoon.formatDate(year: 2024, month: 09, day: 12)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 6)

    // Full Moon at Apr 23  23:48
    date = TinyMoon.formatDate(year: 2024, month: 04, day: 20)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 3)

    // Full Moon at Nov 15  21:28
    date = TinyMoon.formatDate(year: 2024, month: 11, day: 13)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 2)
  }

  func test_moon_daysUntilNewMoon() {
    // Full Moon at May 8  03:21
    var date = TinyMoon.formatDate(year: 2024, month: 05, day: 06)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var daysTill = TinyMoon.Moon.daysUntilNewMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 2)

    // Full Moon at Jul 5  22:57
    date = TinyMoon.formatDate(year: 2024, month: 07, day: 02)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 3)

    // Full Moon at Sep 3  01:55
    date = TinyMoon.formatDate(year: 2024, month: 08, day: 30)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 4)
  }

  func test_moon_uniquePhases() {
    var emojisByMonth = [MonthTestHelper.Month: Int]()

    MonthTestHelper.Month.allCases.forEach { month in
      let moons = MoonTestHelper.moonMonth(month: month, year: 2024)
      let emojis = moons.compactMap { moon in
        switch moon.moonPhase {
        case .newMoon, .firstQuarter, .fullMoon, .lastQuarter:
          return moon.emoji
        default:
          break
        }
        return nil
      }

      emojisByMonth[month] = emojis.count
    }

    MonthTestHelper.Month.allCases.forEach { month in
      switch month {
      case .march, .december:
        XCTAssertEqual(emojisByMonth[month], 5)
      default:
        XCTAssertEqual(emojisByMonth[month], 4)
      }
    }
  }

  func test_julianDaysFor24HourPeriod() {
    // January 11, 2024
    var date = TinyMoon.formatDate(year: 2024, month: 01, day: 11, hour: 00)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var julianDaysFor24HourPeriod = TinyMoon.Moon.julianDaysFor24HourPeriod(julianDay: julianDay)
    XCTAssertEqual(julianDaysFor24HourPeriod, [2460320.5, 2460320.75, 2460321.0, 2460321.25])

    date = TinyMoon.formatDate(year: 2024, month: 01, day: 11, hour: 06)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    julianDaysFor24HourPeriod = TinyMoon.Moon.julianDaysFor24HourPeriod(julianDay: julianDay)
    XCTAssertEqual(julianDaysFor24HourPeriod, [2460320.5, 2460320.75, 2460321.0, 2460321.25])

    date = TinyMoon.formatDate(year: 2024, month: 01, day: 11, hour: 09)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    julianDaysFor24HourPeriod = TinyMoon.Moon.julianDaysFor24HourPeriod(julianDay: julianDay)
    XCTAssertEqual(julianDaysFor24HourPeriod, [2460320.5, 2460320.75, 2460321.0, 2460321.25])

    date = TinyMoon.formatDate(year: 2024, month: 01, day: 11, hour: 12)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    julianDaysFor24HourPeriod = TinyMoon.Moon.julianDaysFor24HourPeriod(julianDay: julianDay)
    XCTAssertEqual(julianDaysFor24HourPeriod, [2460320.5, 2460320.75, 2460321.0, 2460321.25])

    date = TinyMoon.formatDate(year: 2024, month: 01, day: 11, hour: 16)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    julianDaysFor24HourPeriod = TinyMoon.Moon.julianDaysFor24HourPeriod(julianDay: julianDay)
    XCTAssertEqual(julianDaysFor24HourPeriod, [2460320.5, 2460320.75, 2460321.0, 2460321.25])

    date = TinyMoon.formatDate(year: 2024, month: 01, day: 11, hour: 18)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    julianDaysFor24HourPeriod = TinyMoon.Moon.julianDaysFor24HourPeriod(julianDay: julianDay)
    XCTAssertEqual(julianDaysFor24HourPeriod, [2460320.5, 2460320.75, 2460321.0, 2460321.25])

    date = TinyMoon.formatDate(year: 2024, month: 01, day: 11, hour: 23)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    julianDaysFor24HourPeriod = TinyMoon.Moon.julianDaysFor24HourPeriod(julianDay: julianDay)
    XCTAssertEqual(julianDaysFor24HourPeriod, [2460320.5, 2460320.75, 2460321.0, 2460321.25])

    // January 12, 2024
    date = TinyMoon.formatDate(year: 2024, month: 01, day: 12, hour: 00)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    julianDaysFor24HourPeriod = TinyMoon.Moon.julianDaysFor24HourPeriod(julianDay: julianDay)
    XCTAssertEqual(julianDaysFor24HourPeriod, [2460321.5, 2460321.75, 2460322.0, 2460322.25])

    date = TinyMoon.formatDate(year: 2024, month: 01, day: 12, hour: 06)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    julianDaysFor24HourPeriod = TinyMoon.Moon.julianDaysFor24HourPeriod(julianDay: julianDay)
    XCTAssertEqual(julianDaysFor24HourPeriod, [2460321.5, 2460321.75, 2460322.0, 2460322.25])

    date = TinyMoon.formatDate(year: 2024, month: 01, day: 12, hour: 12)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    julianDaysFor24HourPeriod = TinyMoon.Moon.julianDaysFor24HourPeriod(julianDay: julianDay)
    XCTAssertEqual(julianDaysFor24HourPeriod, [2460321.5, 2460321.75, 2460322.0, 2460322.25])

    date = TinyMoon.formatDate(year: 2024, month: 01, day: 12, hour: 18)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    julianDaysFor24HourPeriod = TinyMoon.Moon.julianDaysFor24HourPeriod(julianDay: julianDay)
    XCTAssertEqual(julianDaysFor24HourPeriod, [2460321.5, 2460321.75, 2460322.0, 2460322.25])
  }
}

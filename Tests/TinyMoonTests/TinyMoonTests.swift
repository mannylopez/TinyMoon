import XCTest
@testable import TinyMoon

final class TinyMoonTests: XCTestCase {

  func test_moon_daysUntilFullMoon() {
    // Jun 22
    var date = TinyMoon.formatDate(year: 2024, month: 06, day: 20)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var daysTill = TinyMoon.Moon.daysUntilFullMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 2)

    // Sep 18  02:34
    date = TinyMoon.formatDate(year: 2024, month: 09, day: 12)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 6)

    // Apr 23  23:48
    date = TinyMoon.formatDate(year: 2024, month: 04, day: 20)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 3)

    // Nov 15  21:28
    date = TinyMoon.formatDate(year: 2024, month: 11, day: 13)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 2)
  }

  func test_moon_daysUntilNewMoon() {
    // May 8  03:21
    var date = TinyMoon.formatDate(year: 2024, month: 05, day: 06)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var daysTill = TinyMoon.Moon.daysUntilNewMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 2)

    // Jul 5  22:57
    date = TinyMoon.formatDate(year: 2024, month: 07, day: 02)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 3)

    // Sep 3  01:55
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
}

import XCTest
@testable import TinyMoon

final class TinyMoonTests: XCTestCase {
  func test_tinyMoon_calculateMoonPhase_returnsFullMoon() throws {
    let date = TinyMoon.formatDate(year: 2024, month: 04, day: 23)
    let moon = TinyMoon.calculateMoonPhase(date)

    XCTAssertTrue(moon.isFullMoon())
    XCTAssertEqual(moon.fullMoonName, "Pink Moon")
    XCTAssertEqual(moon.daysTillFullMoon, 0)
    XCTAssertEqual(moon.emoji, "\u{1F315}") // 🌕
  }

  func test_moon_daysTillFullMoon_returnsCorrectDays() throws {
    let date = TinyMoon.formatDate(year: 2024, month: 04, day: 22)
    let moon = TinyMoon.calculateMoonPhase(date)

    XCTAssertFalse(moon.isFullMoon())
    XCTAssertNil(moon.fullMoonName)
    XCTAssertEqual(moon.daysTillFullMoon, 1)
    XCTAssertEqual(moon.emoji, "\u{1F314}") // 🌔
  }

  func test_tinyMoon_calculateMoonPhase_returnsNewMoon() throws {
    var date = TinyMoon.formatDate(year: 2024, month: 11, day: 01)
    var moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.emoji, "\u{1F311}") // 🌑
    XCTAssertEqual(moon.daysTillNewMoon, 0)

    date = TinyMoon.formatDate(year: 2024, month: 12, day: 1)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.emoji, "\u{1F311}") // 🌑
    XCTAssertEqual(moon.daysTillNewMoon, 0)
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

  func test_moon_julianDay() {
    // January 6, 2000 @ 00:00:00.0
    var date = TinyMoon.formatDate(year: 2000, month: 01, day: 06)
    var julianDay = TinyMoon.Moon.julianDay(date)
    XCTAssertEqual(julianDay, 2451549.5000)

    // January 6, 2000 @ 20:00:00.0
    date = TinyMoon.formatDate(year: 2000, month: 01, day: 06, hour: 20, minute: 00)
    julianDay = TinyMoon.Moon.julianDay(date)
    XCTAssertEqual(julianDay, 2451550.3333)

    // August 22, 2022 @ 00:00:00.0
    date = TinyMoon.formatDate(year: 2022, month: 08, day: 22, hour: 00, minute: 00)
    julianDay = TinyMoon.Moon.julianDay(date)
    XCTAssertEqual(julianDay, 2459813.5000)

    // August 22, 2022 @ 04:05:00.0
    date = TinyMoon.formatDate(year: 2022, month: 08, day: 22, hour: 04, minute: 05)
    julianDay = TinyMoon.Moon.julianDay(date)
    XCTAssertEqual(julianDay, 2459813.6701)
  }

  func test_moon_lessPreciseJulianDay() {
    // January 6, 2000 @ 00:00:00.0
    var julianDay = TinyMoon.Moon.lessPreciseJulianDay(year: 2000, month: 01, day: 06)
    XCTAssertEqual(julianDay, 2451549.5)

    // December 6, 2008 @ @ 00:00:00.0
    julianDay = TinyMoon.Moon.lessPreciseJulianDay(year: 2008, month: 12, day: 06)
    XCTAssertEqual(julianDay, 2454806.5)
//
    // August 22, 2022 @ 00:00:00.0
    julianDay = TinyMoon.Moon.lessPreciseJulianDay(year: 2022, month: 08, day: 22)
    XCTAssertEqual(julianDay, 2459813.5)
  }
}

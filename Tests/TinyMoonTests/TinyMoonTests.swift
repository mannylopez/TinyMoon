import XCTest
@testable import TinyMoon

final class TinyMoonTests: XCTestCase {
  func test_tinyMoon_calculateMoonPhase_returnsFullMoon() throws {
    let date = MoonTestHelper.formatDate(year: 2024, month: 04, day: 23)
    let moon = TinyMoon.calculateMoonPhase(date)

    XCTAssertTrue(moon.isFullMoon())
    XCTAssertEqual(moon.fullMoonName, "Pink Moon")
    XCTAssertEqual(moon.daysTillFullMoon, 0)
    XCTAssertEqual(moon.emoji, "\u{1F315}") // 🌕
  }

  func test_moon_daysTillFullMoon_returnsCorrectDays() throws {
    let date = MoonTestHelper.formatDate(year: 2024, month: 04, day: 22)
    let moon = TinyMoon.calculateMoonPhase(date)

    XCTAssertFalse(moon.isFullMoon())
    XCTAssertNil(moon.fullMoonName)
    XCTAssertEqual(moon.daysTillFullMoon, 1)
    XCTAssertEqual(moon.emoji, "\u{1F314}") // 🌔
  }

  func test_tinyMoon_calculateMoonPhase_returnsNewMoon() throws {
    var date = MoonTestHelper.formatDate(year: 2024, month: 11, day: 01)
    var moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.emoji, "\u{1F311}") // 🌑
    XCTAssertEqual(moon.daysTillNewMoon, 0)

    date = MoonTestHelper.formatDate(year: 2024, month: 12, day: 1)
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
}


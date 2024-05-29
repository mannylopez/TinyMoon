import XCTest
@testable import TinyMoon

final class TinyMoonTests: XCTestCase {
  func test_tinyMoon_calculateMoonPhase_returnsFullMoon() throws {
    let date = TestHelper.formatDate(year: 2024, month: 04, day: 23)
    let moon = TestHelper().tinyMoon.calculateMoonPhase(date)

    XCTAssertTrue(moon.isFullMoon())
    XCTAssertEqual(moon.fullMoonName, "Pink Moon")
    XCTAssertEqual(moon.daysTillFullMoon, 0)
    XCTAssertEqual(moon.emoji, "\u{1F315}") // 🌕
  }

  func test_moon_daysTillFullMoon_returnsCorrectDays() throws {
    let date = TestHelper.formatDate(year: 2024, month: 04, day: 22)
    let moon = TestHelper().tinyMoon.calculateMoonPhase(date)

    XCTAssertFalse(moon.isFullMoon())
    XCTAssertNil(moon.fullMoonName)
    XCTAssertEqual(moon.daysTillFullMoon, 1)
    XCTAssertEqual(moon.emoji, "\u{1F314}") // 🌔
  }

  func test_tinyMoon_calculateMoonPhase_returnsNewMoon() throws {
    var date = TestHelper.formatDate(year: 2024, month: 11, day: 01)
    let testHelper = TestHelper()
    var moon = testHelper.tinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.emoji, "\u{1F311}") // 🌑

    date = TestHelper.formatDate(year: 2024, month: 12, day: 1)
    moon = testHelper.tinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.emoji, "\u{1F311}") // 🌑
  }
}


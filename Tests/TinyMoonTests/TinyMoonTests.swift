import XCTest
@testable import TinyMoon

final class TinyMoonTests: XCTestCase {
  func test_tinyMoon_calculateMoonPhase_returnsFullMoon() throws {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    let fullMoonDate = formatter.date(from: "2024/04/23 00:00")
    let tinyMoon = TinyMoon()
    let moonPhase = tinyMoon.calculateMoonPhase(fullMoonDate!)
    XCTAssertTrue(moonPhase.isFullMoon())
    XCTAssertEqual(moonPhase.fullMoonName, "Pink Moon")
    XCTAssertEqual(moonPhase.daysTillFullMoon, 0)
    XCTAssertEqual(moonPhase.emoji, "\u{1F315}") // 🌕
  }

  func test_moon_daysTillFullMoon_returnsCorrectDays() throws {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    let fullMoonDate = formatter.date(from: "2024/04/22 00:00")
    let tinyMoon = TinyMoon()
    let moonPhase = tinyMoon.calculateMoonPhase(fullMoonDate!)
    XCTAssertFalse(moonPhase.isFullMoon())
    XCTAssertNil(moonPhase.fullMoonName)
    XCTAssertEqual(moonPhase.daysTillFullMoon, 1)
    XCTAssertEqual(moonPhase.emoji, "\u{1F314}") // 🌔
  }
}

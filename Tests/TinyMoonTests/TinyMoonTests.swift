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

  // MARK: - AstronomicalConstant tests

  func test_moon_julianDay() {
    // January 6, 2000 @ 00:00:00.0
    var date = TinyMoon.formatDate(year: 2000, month: 01, day: 06)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2451549.5000)

    // January 6, 2000 @ 20:00:00.0
    date = TinyMoon.formatDate(year: 2000, month: 01, day: 06, hour: 20, minute: 00)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2451550.3333)

    // August 22, 2022 @ 00:00:00.0
    date = TinyMoon.formatDate(year: 2022, month: 08, day: 22, hour: 00, minute: 00)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2459813.5000)

    // August 22, 2022 @ 04:05:00.0
    date = TinyMoon.formatDate(year: 2022, month: 08, day: 22, hour: 04, minute: 05)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2459813.6701)
  }

  func test_moon_lessPreciseJulianDay() {
    // January 6, 2000 @ 00:00:00.0
    var julianDay = TinyMoon.AstronomicalConstant.lessPreciseJulianDay(year: 2000, month: 01, day: 06)
    XCTAssertEqual(julianDay, 2451549.5)

    // December 6, 2008 @ @ 00:00:00.0
    julianDay = TinyMoon.AstronomicalConstant.lessPreciseJulianDay(year: 2008, month: 12, day: 06)
    XCTAssertEqual(julianDay, 2454806.5)

    // August 22, 2022 @ 00:00:00.0
    julianDay = TinyMoon.AstronomicalConstant.lessPreciseJulianDay(year: 2022, month: 08, day: 22)
    XCTAssertEqual(julianDay, 2459813.5)
  }

  func test_astronomicalConstant_daysSinceJ2000() {
    let date = TinyMoon.formatDate(year: 2004, month: 01, day: 1)
    let julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2453005.5000)

    let daysSinceJ2000 = TinyMoon.AstronomicalConstant.daysSinceJ2000(from: julianDay)
    XCTAssertEqual(daysSinceJ2000, 1460.5)
  }

  func test_astronomicalConstant_moonPosition() {
    let date = TinyMoon.formatDate(year: 2004, month: 01, day: 1)
    let julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    let moonCoordinates = TinyMoon.AstronomicalConstant.moonCoordinates(julianDay: julianDay)

//    XCTAssertEqual(L, 22.44235800000024)  // 22.44 degrees
//    XCTAssertEqual(M, 136.38527649999742) // 136.39 degrees
//    XCTAssertEqual(F, 334.7376750000003)  // 334.74 degrees

    // Test values taken from https://aa.quae.nl/en/reken/hemelpositie.html#4
    XCTAssertEqual(moonCoordinates.longitude, 26.78054550631917)
    XCTAssertEqual(moonCoordinates.latitude, -2.188442146158122)
    XCTAssertEqual(moonCoordinates.distance, 400136)
  }

  func test_astronomicalConstant_declination() {
    // Test values taken from https://aa.quae.nl/en/reken/hemelpositie.html#1_7
    let longitude = TinyMoon.AstronomicalConstant.degreesToRadians(168.737)
    let latitude = TinyMoon.AstronomicalConstant.degreesToRadians(1.208)
    let declination = TinyMoon.AstronomicalConstant.declination(longitude: longitude, latitude: latitude)

    XCTAssertEqual(declination, TinyMoon.AstronomicalConstant.degreesToRadians(5.567), accuracy: 1e-5)

    XCTAssertEqual(declination, 0.09717015472346271, accuracy: 1e-5)
  }

  func test_astronomicalConstant_rightAscension() {
    // Test values taken from https://aa.quae.nl/en/reken/hemelpositie.html#1_7
    let longitude = TinyMoon.AstronomicalConstant.degreesToRadians(168.737)
    let latitude = TinyMoon.AstronomicalConstant.degreesToRadians(1.208)
    let rightAscension = TinyMoon.AstronomicalConstant.rightAscension(longitude: longitude, latitude: latitude)

    XCTAssertEqual(rightAscension, TinyMoon.AstronomicalConstant.degreesToRadians(170.20), accuracy: 0.0015)

    XCTAssertEqual(rightAscension, 2.969160475404514)
  }

  func test_astronomicalConstant_solarMeanAnomaly() {
    let date = TinyMoon.formatDate(year: 2004, month: 01, day: 1)
    let julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    let solarMeanAnomaly = TinyMoon.AstronomicalConstant.solarMeanAnomaly(julianDay: julianDay)
    XCTAssertEqual(solarMeanAnomaly, 31.363535104530555)
  }
}

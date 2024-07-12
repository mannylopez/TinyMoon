// Created by manny_lopez on 6/6/24.

import XCTest
@testable import TinyMoon

// MARK: - AstronomicalConstant tests

final class AstronomicalConstantTests: XCTestCase {

  func test_astronomicalConstant_degreesToRadians() {
    let degrees = 5729.58
    let radians = 100.00003575641671
    let convertedUnit = TinyMoon.AstronomicalConstant.degreesToRadians(degrees)
    XCTAssertEqual(convertedUnit, radians)
  }

  func test_astronomicalConstant_radiansToDegrees() {
    let degrees = 5729.58
    let radians = 100.00003575641671
    let convertedUnit = TinyMoon.AstronomicalConstant.radiansToDegrees(radians)
    XCTAssertEqual(convertedUnit, degrees)
  }

  func test_astronomicalConstant_julianDay() {
    let pacificTimeZone = TinyMoon.TimeZoneOption.createTimeZone(timeZone: .pacific)

    // January 6, 2000 @ 00:00:00
    var date = TinyMoon.formatDate(year: 2000, month: 01, day: 06)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2451549.5000)

    // January 6, 2000 @ 00:00: Pacific
    // January 6, 2000 @ 08:00:00 UTC
    date = TinyMoon.formatDate(
      year: 2000,
      month: 01,
      day: 06,
      hour: 0,
      timeZone: pacificTimeZone)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2451549.8333333335)

    // January 5, 2000 @ 16:00: Pacific
    // January 6, 2000 @ 00:00:00 UTC
    date = TinyMoon.formatDate(
      year: 2000,
      month: 01,
      day: 5,
      hour: 16,
      timeZone: pacificTimeZone)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2451549.5000)

    // January 6, 2000 @ 20:00:00
    date = TinyMoon.formatDate(year: 2000, month: 01, day: 06, hour: 20, minute: 00)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2451550.3333333335)

    // August 22, 2022 @ 00:00:00
    date = TinyMoon.formatDate(year: 2022, month: 08, day: 22, hour: 00, minute: 00)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2459813.5000)

    // August 22, 2022 @ 04:05:00
    date = TinyMoon.formatDate(year: 2022, month: 08, day: 22, hour: 04, minute: 05)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2459813.670138889)

    // August 22, 2022 @ 14:05:00
    date = TinyMoon.formatDate(year: 2022, month: 08, day: 22, hour: 14, minute: 05)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2459814.0868055555)

    date = TinyMoon.formatDate(year: 2022, month: 08, day: 22, hour: 23, minute: 59)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2459814.4993055556)
  }

  func test_astronomicalConstant_getMoonPhase() {
    // Full moon
    var date = TinyMoon.formatDate(year: 2024, month: 06, day: 22)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var moonPhase = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay)

    XCTAssertEqual(moonPhase.illuminatedFraction, 0.9999732292206713)
    XCTAssertEqual(moonPhase.phase, 0.49835304181785745)

    // New moon
    date = TinyMoon.formatDate(year: 2024, month: 07, day: 06, hour: 12, minute: 37)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    moonPhase = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay)

    XCTAssertEqual(moonPhase.illuminatedFraction, 0.0036280068150687517)
    XCTAssertEqual(moonPhase.phase, 0.019184351732275336)

    // First quarter
    date = TinyMoon.formatDate(year: 2024, month: 08, day: 12, hour: 15, minute: 18)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    moonPhase = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay)

    XCTAssertEqual(moonPhase.illuminatedFraction, 0.5017120238066795)
    XCTAssertEqual(moonPhase.phase, 0.2505449551679033)

    // Last quarter
    date = TinyMoon.formatDate(year: 2024, month: 08, day: 26, hour: 09, minute: 25)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    moonPhase = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay)

    XCTAssertEqual(moonPhase.illuminatedFraction, 0.49982435665155855)
    XCTAssertEqual(moonPhase.phase, 0.7500559090154013)
  }
}

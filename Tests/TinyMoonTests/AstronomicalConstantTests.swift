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
    let pacificTimeZone = TimeTestHelper.TimeZoneOption.createTimeZone(timeZone: .pacific)

    // January 6, 2000 @ 00:00:00
    var date = TimeTestHelper.formatDate(year: 2000, month: 01, day: 06)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2451549.5000)

    // January 6, 2000 @ 00:00: Pacific
    // January 6, 2000 @ 08:00:00 UTC
    date = TimeTestHelper.formatDate(
      year: 2000,
      month: 01,
      day: 06,
      hour: 0,
      timeZone: pacificTimeZone)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2451549.8333333335)

    // January 5, 2000 @ 16:00: Pacific
    // January 6, 2000 @ 00:00:00 UTC
    date = TimeTestHelper.formatDate(
      year: 2000,
      month: 01,
      day: 5,
      hour: 16,
      timeZone: pacificTimeZone)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2451549.5000)

    // January 6, 2000 @ 20:00:00
    date = TimeTestHelper.formatDate(year: 2000, month: 01, day: 06, hour: 20, minute: 00)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2451550.3333333335)

    // August 22, 2022 @ 00:00:00
    date = TimeTestHelper.formatDate(year: 2022, month: 08, day: 22, hour: 00, minute: 00)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2459813.5000)

    // August 22, 2022 @ 04:05:00
    date = TimeTestHelper.formatDate(year: 2022, month: 08, day: 22, hour: 04, minute: 05)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2459813.670138889)

    // August 22, 2022 @ 14:05:00
    date = TimeTestHelper.formatDate(year: 2022, month: 08, day: 22, hour: 14, minute: 05)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2459814.0868055555)

    date = TimeTestHelper.formatDate(year: 2022, month: 08, day: 22, hour: 23, minute: 59)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2459814.4993055556)
  }

  func test_astronomicalConstant_getMoonPhase_moonDetail() {
    // Full moon
    var date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 22)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var moonDetail = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay)

    XCTAssertEqual(moonDetail.julianDay, 2460483.5)
    XCTAssertEqual(moonDetail.daysElapsedInCycle, 14.716658695349988)
    XCTAssertEqual(moonDetail.ageOfMoon.days, 14)
    XCTAssertEqual(moonDetail.ageOfMoon.hours, 17)
    XCTAssertEqual(moonDetail.ageOfMoon.minutes, 11)
    XCTAssertEqual(moonDetail.illuminatedFraction, 0.9999732292206713)
    XCTAssertEqual(moonDetail.distanceFromCenterOfEarth, 382758.57898868265)
    XCTAssertEqual(moonDetail.phase, 0.49835304181785745)

    // New moon
    date = TimeTestHelper.formatDate(year: 2024, month: 07, day: 06, hour: 12, minute: 37)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    moonDetail = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay)

    XCTAssertEqual(moonDetail.julianDay, 2460498.0256944443)
    XCTAssertEqual(moonDetail.daysElapsedInCycle, 0.5665252000982685)
    XCTAssertEqual(moonDetail.ageOfMoon.days, 0)
    XCTAssertEqual(moonDetail.ageOfMoon.hours, 13)
    XCTAssertEqual(moonDetail.ageOfMoon.minutes, 35)
    XCTAssertEqual(moonDetail.illuminatedFraction, 0.0036280068150687517)
    XCTAssertEqual(moonDetail.distanceFromCenterOfEarth, 390943.47575863753)
    XCTAssertEqual(moonDetail.phase, 0.019184351732275336)

    // First quarter
    date = TimeTestHelper.formatDate(year: 2024, month: 08, day: 12, hour: 15, minute: 18)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    moonDetail = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay)

    XCTAssertEqual(moonDetail.julianDay, 2460535.1375)
    XCTAssertEqual(moonDetail.daysElapsedInCycle, 7.398740016912393)
    XCTAssertEqual(moonDetail.ageOfMoon.days, 7)
    XCTAssertEqual(moonDetail.ageOfMoon.hours, 9)
    XCTAssertEqual(moonDetail.ageOfMoon.minutes, 34)
    XCTAssertEqual(moonDetail.illuminatedFraction, 0.5017120238066795)
    XCTAssertEqual(moonDetail.distanceFromCenterOfEarth, 398519.14701141417)
    XCTAssertEqual(moonDetail.phase, 0.2505449551679033)

    // Last quarter
    date = TimeTestHelper.formatDate(year: 2024, month: 08, day: 26, hour: 09, minute: 25)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    moonDetail = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay)

    XCTAssertEqual(moonDetail.julianDay, 2460548.892361111)
    XCTAssertEqual(moonDetail.daysElapsedInCycle, 22.14959253613732)
    XCTAssertEqual(moonDetail.ageOfMoon.days, 22)
    XCTAssertEqual(moonDetail.ageOfMoon.hours, 3)
    XCTAssertEqual(moonDetail.ageOfMoon.minutes, 35)
    XCTAssertEqual(moonDetail.illuminatedFraction, 0.49982435665155855)
    XCTAssertEqual(moonDetail.distanceFromCenterOfEarth, 372205.09027872747)
    XCTAssertEqual(moonDetail.phase, 0.7500559090154013)
  }

  func test_moontool() {
    // Test taken from https://www.fourmilab.ch/moontoolw/
    let utcTimeZone = TimeTestHelper.TimeZoneOption.createTimeZone(timeZone: .utc)
    let date = TimeTestHelper.formatDate(year: 1999, month: 07, day: 20, hour: 20, minute: 17, second: 40, timeZone: utcTimeZone)
    let julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    let moonDetail = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay)
    XCTAssertEqual(moonDetail.julianDay, 2451380.345601852)
    XCTAssertEqual(moonDetail.ageOfMoon.days, 7)
    XCTAssertEqual(moonDetail.ageOfMoon.hours, 19)
    XCTAssertEqual(moonDetail.ageOfMoon.minutes, 30)
    XCTAssertEqual(round(moonDetail.illuminatedFraction * 100), 55)
    XCTAssertEqual(round(moonDetail.distanceFromCenterOfEarth), 402026)

  }
}

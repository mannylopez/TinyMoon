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

  func test_astronomicalConstant_lessPreciseJulianDay() {
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

  func test_astronomicalConstant_moonCoordinates() {
    let date = TinyMoon.formatDate(year: 2004, month: 01, day: 1)
    let julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    let moonCoordinates = TinyMoon.AstronomicalConstant.moonCoordinates(julianDay: julianDay)

    // Test values taken from https://aa.quae.nl/en/reken/hemelpositie.html#4
//    XCTAssertEqual(moonCoordinates.L, 339.683699626709)  // 22.44 degrees
//    XCTAssertEqual(moonCoordinates.M, 335.3891934066859) // 136.39 degrees
//    XCTAssertEqual(moonCoordinates.F, 338.8510958397388)  // 334.74 degrees
//
//    XCTAssertEqual(moonCoordinates.longitude, 339.7594152822631) // 0.46740869456428196793
//    XCTAssertEqual(moonCoordinates.latitude, -0.038195520939872045) // -0.038195520939775448599

    XCTAssertEqual(moonCoordinates.declination, 0.14456842408751425)
    XCTAssertEqual(moonCoordinates.rightAscension, 0.4475918797699177)
    XCTAssertEqual(moonCoordinates.distance, 400136.10760520655)
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

  func test_astronomicalConstant_eclipticLongitude() {
    let date = TinyMoon.formatDate(year: 2004, month: 01, day: 1)
    let julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    let solarMeanAnomaly = TinyMoon.AstronomicalConstant.solarMeanAnomaly(julianDay: julianDay)
    let eclipticLongitude = TinyMoon.AstronomicalConstant.eclipticLongitude(solarMeanAnomaly: solarMeanAnomaly)
    XCTAssertEqual(eclipticLongitude, 36.29993339416619)
  }

  func test_astronomicalConstant_sunCoordinates() {
    let date = TinyMoon.formatDate(year: 2004, month: 01, day: 1)
    let julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    let moonCoordinates = TinyMoon.AstronomicalConstant.sunCoordinates(julianDay: julianDay)

    XCTAssertEqual(moonCoordinates.declination, -0.4027395448243531)
    XCTAssertEqual(moonCoordinates.rightAscension, -1.3840846794023092)
  }

  func test_astronomicalConstant_getMoonPhase() {
    // Full moon
    var date = TinyMoon.formatDate(year: 2024, month: 06, day: 22)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var moonPhase = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay)

    XCTAssertEqual(moonPhase.illuminatedFraction, 0.9978874952116796)
    XCTAssertEqual(moonPhase.phase, 0.4853646873327652)
    XCTAssertEqual(moonPhase.angle, -2.87048004074093)

    // New moon
    date = TinyMoon.formatDate(year: 2024, month: 07, day: 06, hour: 12, minute: 37)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    moonPhase = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay)

    XCTAssertEqual(moonPhase.illuminatedFraction, 0.0074256887778501035)
    XCTAssertEqual(moonPhase.phase, 0.027463599533906702)
    XCTAssertEqual(moonPhase.angle, -1.9356269936608987)

    // First quarter
    date = TinyMoon.formatDate(year: 2024, month: 08, day: 12, hour: 15, minute: 18)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    moonPhase = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay)

    XCTAssertEqual(moonPhase.illuminatedFraction, 0.5105142058965426)
    XCTAssertEqual(moonPhase.phase, 0.25334702238541357)
    XCTAssertEqual(moonPhase.angle, -1.2995626391218953)

    // Last quarter
    date = TinyMoon.formatDate(year: 2024, month: 08, day: 26, hour: 09, minute: 25)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    moonPhase = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay)

    XCTAssertEqual(moonPhase.illuminatedFraction, 0.5115277719739029)
    XCTAssertEqual(moonPhase.phase, 0.7463302710536945)
    XCTAssertEqual(moonPhase.angle, 1.3632143802303285)
  }
}

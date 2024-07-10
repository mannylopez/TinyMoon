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
    XCTAssertEqual(julianDay, 2451550.3333333335)

    // August 22, 2022 @ 00:00:00.0
    date = TinyMoon.formatDate(year: 2022, month: 08, day: 22, hour: 00, minute: 00)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2459813.5000)

    // August 22, 2022 @ 04:05:00.0
    date = TinyMoon.formatDate(year: 2022, month: 08, day: 22, hour: 04, minute: 05)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2459813.670138889)

    // August 22, 2022 @ 14:05:00.0
    date = TinyMoon.formatDate(year: 2022, month: 08, day: 22, hour: 14, minute: 05)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2459814.0868055555)

    date = TinyMoon.formatDate(year: 2022, month: 08, day: 22, hour: 23, minute: 59)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2459814.4993055556)
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
    // 1
    var date = TinyMoon.formatDate(year: 2004, month: 01, day: 1)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2453005.5000)

    var daysSinceJ2000 = TinyMoon.AstronomicalConstant.daysSinceJ2000(from: julianDay)
    XCTAssertEqual(daysSinceJ2000, 1460.5)

    // 2
    date = TinyMoon.formatDate(year: 2022, month: 08, day: 22, hour: 23, minute: 59)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    XCTAssertEqual(julianDay, 2459814.4993055556)

    daysSinceJ2000 = TinyMoon.AstronomicalConstant.daysSinceJ2000(from: julianDay)
    XCTAssertEqual(daysSinceJ2000, 8269.499305555597)
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
    var date = TinyMoon.formatDate(year: 2004, month: 01, day: 1)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var solarMeanAnomaly = TinyMoon.AstronomicalConstant.solarMeanAnomaly(julianDay: julianDay)
    XCTAssertEqual(solarMeanAnomaly, 31.363537143773254)

    date = TinyMoon.formatDate(year: 2005, month: 02, day: 2)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    solarMeanAnomaly = TinyMoon.AstronomicalConstant.solarMeanAnomaly(julianDay: julianDay)
    XCTAssertEqual(solarMeanAnomaly, 38.20992120161531)

    date = TinyMoon.formatDate(year: 2006, month: 03, day: 10)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    solarMeanAnomaly = TinyMoon.AstronomicalConstant.solarMeanAnomaly(julianDay: julianDay)
    XCTAssertEqual(solarMeanAnomaly, 45.107911169441095)

    date = TinyMoon.formatDate(year: 2006, month: 03, day: 10, hour: 6)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    solarMeanAnomaly = TinyMoon.AstronomicalConstant.solarMeanAnomaly(julianDay: julianDay)
    XCTAssertEqual(solarMeanAnomaly, 45.11221166193974)

    date = TinyMoon.formatDate(year: 2016, month: 04, day: 15, hour: 6)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    solarMeanAnomaly = TinyMoon.AstronomicalConstant.solarMeanAnomaly(julianDay: julianDay)
    XCTAssertEqual(solarMeanAnomaly, 108.57027897193804)

    date = TinyMoon.formatDate(year: 2016, month: 04, day: 15, hour: 6, minute: 5)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    solarMeanAnomaly = TinyMoon.AstronomicalConstant.solarMeanAnomaly(julianDay: julianDay)
    XCTAssertEqual(solarMeanAnomaly, 108.57033870099696)

    date = TinyMoon.formatDate(year: 2016, month: 04, day: 15, hour: 6, minute: 30)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    solarMeanAnomaly = TinyMoon.AstronomicalConstant.solarMeanAnomaly(julianDay: julianDay)
    XCTAssertEqual(solarMeanAnomaly, 108.57063734631559)

    date = TinyMoon.formatDate(year: 2020, month: 10, day: 20, hour: 9, minute: 25)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    solarMeanAnomaly = TinyMoon.AstronomicalConstant.solarMeanAnomaly(julianDay: julianDay)
    XCTAssertEqual(solarMeanAnomaly, 136.93877638455712)
  }

  func test_astronomicalConstant_eclipticLongitude() {
    let date = TinyMoon.formatDate(year: 2004, month: 01, day: 1)
    let julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    let solarMeanAnomaly = TinyMoon.AstronomicalConstant.solarMeanAnomaly(julianDay: julianDay)
    let eclipticLongitude = TinyMoon.AstronomicalConstant.eclipticLongitude(solarMeanAnomaly: solarMeanAnomaly)
    XCTAssertEqual(eclipticLongitude, 36.299935502913485)
  }

  func test_astronomicalConstant_sunCoordinates() {
    let date = TinyMoon.formatDate(year: 2004, month: 01, day: 1)
    let julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    let sunCoordinates = TinyMoon.AstronomicalConstant.sunCoordinates(julianDay: julianDay)

    XCTAssertEqual(sunCoordinates.declination, -0.4027393891133564)
    XCTAssertEqual(sunCoordinates.rightAscension, -1.3840823935200117)
  }

  func test_astronomicalConstant_getMoonPhase() {
    // Full moon
    var date = TinyMoon.formatDate(year: 2024, month: 06, day: 22)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var moonPhase = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay)

    XCTAssertEqual(moonPhase.illuminatedFraction, 0.9978873506056865)
    XCTAssertEqual(moonPhase.phase, 0.48536418607701615)
    XCTAssertEqual(moonPhase.angle, -2.8703533722710577)

    // New moon
    date = TinyMoon.formatDate(year: 2024, month: 07, day: 06, hour: 12, minute: 37)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    moonPhase = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay)

    XCTAssertEqual(moonPhase.illuminatedFraction, 0.007424715413253902)
    XCTAssertEqual(moonPhase.phase, 0.02746179502131707)
    XCTAssertEqual(moonPhase.angle, -1.9356676727903563)

    // First quarter
    date = TinyMoon.formatDate(year: 2024, month: 08, day: 12, hour: 15, minute: 18)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    moonPhase = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay)

    XCTAssertEqual(moonPhase.illuminatedFraction, 0.5105081080980992)
    XCTAssertEqual(moonPhase.phase, 0.25334508096684466)
    XCTAssertEqual(moonPhase.angle, -1.2995618398922297)

    // Last quarter
    date = TinyMoon.formatDate(year: 2024, month: 08, day: 26, hour: 09, minute: 25)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    moonPhase = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay)

    XCTAssertEqual(moonPhase.illuminatedFraction, 0.5115383513011658)
    XCTAssertEqual(moonPhase.phase, 0.7463269026530461)
    XCTAssertEqual(moonPhase.angle, 1.3632094278875226)
  }
}

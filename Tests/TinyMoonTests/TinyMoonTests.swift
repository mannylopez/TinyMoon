import XCTest
@testable import TinyMoon

final class TinyMoonTests: XCTestCase {

  func moon_daysUntilFullMoon() {
    // Full Moon at Jun 22  01:07
    var date = TinyMoon.formatDate(year: 2024, month: 06, day: 20)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var daysTill = TinyMoon.Moon.daysUntilFullMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 2)

    // Full Moon at Sep 18  02:34
    date = TinyMoon.formatDate(year: 2024, month: 09, day: 12)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 6)

    // Full Moon at Apr 23  23:48
    date = TinyMoon.formatDate(year: 2024, month: 04, day: 20)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 3)

    // Full Moon at Nov 15  21:28
    date = TinyMoon.formatDate(year: 2024, month: 11, day: 13)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 2)
  }

  func moon_daysUntilNewMoon() {
    // Full Moon at May 8  03:21
    var date = TinyMoon.formatDate(year: 2024, month: 05, day: 06)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var daysTill = TinyMoon.Moon.daysUntilNewMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 2)

    // Full Moon at Jul 5  22:57
    date = TinyMoon.formatDate(year: 2024, month: 07, day: 02)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(julianDay: julianDay)
    XCTAssertEqual(daysTill, 3)

    // Full Moon at Sep 3  01:55
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
      case .may, .december:
        XCTAssertEqual(emojisByMonth[month], 5)
      default:
        XCTAssertEqual(emojisByMonth[month], 4)
      }
    }
  }

  func test_moon_startAndEndOfJulianDay() {
    var date = TinyMoon.formatDate(year: 2024, month: 01, day: 11, hour: 00)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var beginningAndEndJulianDays = TinyMoon.Moon.startAndEndOfJulianDay(julianDay: julianDay)
    XCTAssertEqual(beginningAndEndJulianDays.start, 2460320.5)
    XCTAssertEqual(beginningAndEndJulianDays.end, 2460321.4993)

    date = TinyMoon.formatDate(year: 2024, month: 01, day: 11, hour: 06)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    beginningAndEndJulianDays = TinyMoon.Moon.startAndEndOfJulianDay(julianDay: julianDay)
    XCTAssertEqual(beginningAndEndJulianDays.start, 2460320.5)
    XCTAssertEqual(beginningAndEndJulianDays.end, 2460321.4993)

    date = TinyMoon.formatDate(year: 2024, month: 01, day: 11, hour: 09)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    beginningAndEndJulianDays = TinyMoon.Moon.startAndEndOfJulianDay(julianDay: julianDay)
    XCTAssertEqual(beginningAndEndJulianDays.start, 2460320.5)
    XCTAssertEqual(beginningAndEndJulianDays.end, 2460321.4993)

    date = TinyMoon.formatDate(year: 2024, month: 01, day: 11, hour: 12)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    beginningAndEndJulianDays = TinyMoon.Moon.startAndEndOfJulianDay(julianDay: julianDay)
    XCTAssertEqual(beginningAndEndJulianDays.start, 2460320.5)
    XCTAssertEqual(beginningAndEndJulianDays.end, 2460321.4993)

    date = TinyMoon.formatDate(year: 2024, month: 01, day: 11, hour: 23, minute: 18)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    beginningAndEndJulianDays = TinyMoon.Moon.startAndEndOfJulianDay(julianDay: julianDay)
    XCTAssertEqual(beginningAndEndJulianDays.start, 2460320.5)
    XCTAssertEqual(beginningAndEndJulianDays.end, 2460321.4993)

    date = TinyMoon.formatDate(year: 2024, month: 01, day: 12, hour: 05)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    beginningAndEndJulianDays = TinyMoon.Moon.startAndEndOfJulianDay(julianDay: julianDay)
    XCTAssertEqual(beginningAndEndJulianDays.start, 2460321.5)
    XCTAssertEqual(beginningAndEndJulianDays.end, 2460322.4993)
  }

  func test_moon_majorMoonPhaseInRange() throws {
    // Full Moon
    var date = TinyMoon.formatDate(year: 2024, month: 04, day: 23)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var beginningAndEndJulianDays = TinyMoon.Moon.startAndEndOfJulianDay(julianDay: julianDay)
    var startMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: beginningAndEndJulianDays.start).phase
    var endMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: beginningAndEndJulianDays.end).phase
    XCTAssertNil(TinyMoon.Moon.majorMoonPhaseInRange(start: startMoonPhaseFraction, end: endMoonPhaseFraction))

    date = TinyMoon.formatDate(year: 2024, month: 04, day: 24)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    beginningAndEndJulianDays = TinyMoon.Moon.startAndEndOfJulianDay(julianDay: julianDay)
    startMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: beginningAndEndJulianDays.start).phase
    endMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: beginningAndEndJulianDays.end).phase
    var fullMoon = try XCTUnwrap(TinyMoon.Moon.majorMoonPhaseInRange(start: startMoonPhaseFraction, end: endMoonPhaseFraction))
    XCTAssertEqual(fullMoon, .fullMoon)

    // Full Moon
    date = TinyMoon.formatDate(year: 2024, month: 01, day: 25)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    beginningAndEndJulianDays = TinyMoon.Moon.startAndEndOfJulianDay(julianDay: julianDay)
    startMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: beginningAndEndJulianDays.start).phase
    endMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: beginningAndEndJulianDays.end).phase
    fullMoon = try XCTUnwrap(TinyMoon.Moon.majorMoonPhaseInRange(start: startMoonPhaseFraction, end: endMoonPhaseFraction))
    XCTAssertEqual(fullMoon, .fullMoon)

    date = TinyMoon.formatDate(year: 2024, month: 1, day: 26)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    beginningAndEndJulianDays = TinyMoon.Moon.startAndEndOfJulianDay(julianDay: julianDay)
    startMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: beginningAndEndJulianDays.start).phase
    endMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: beginningAndEndJulianDays.end).phase
    XCTAssertNil(TinyMoon.Moon.majorMoonPhaseInRange(start: startMoonPhaseFraction, end: endMoonPhaseFraction))

    // New Moon
    date = TinyMoon.formatDate(year: 2024, month: 10, day: 02, hour: 00)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    beginningAndEndJulianDays = TinyMoon.Moon.startAndEndOfJulianDay(julianDay: julianDay)
    startMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: beginningAndEndJulianDays.start).phase
    endMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: beginningAndEndJulianDays.end).phase
    let newMoon = try XCTUnwrap(TinyMoon.Moon.majorMoonPhaseInRange(start: startMoonPhaseFraction, end: endMoonPhaseFraction))
    XCTAssertEqual(newMoon, .newMoon)

    date = TinyMoon.formatDate(year: 2024, month: 10, day: 03, hour: 00)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    beginningAndEndJulianDays = TinyMoon.Moon.startAndEndOfJulianDay(julianDay: julianDay)
    startMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: beginningAndEndJulianDays.start).phase
    endMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: beginningAndEndJulianDays.end).phase
    XCTAssertNil(TinyMoon.Moon.majorMoonPhaseInRange(start: startMoonPhaseFraction, end: endMoonPhaseFraction))
  }

  func test_moon_dayIncludesMajorMoonPhase() throws {
    var date = TinyMoon.formatDate(year: 2024, month: 10, day: 17)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var possibleMajorPhase = TinyMoon.Moon.dayIncludesMajorMoonPhase(julianDay: julianDay)
    let majorPhase = try XCTUnwrap(possibleMajorPhase)
    XCTAssertEqual(majorPhase, .fullMoon)

    date = TinyMoon.formatDate(year: 2024, month: 10, day: 16)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    possibleMajorPhase = TinyMoon.Moon.dayIncludesMajorMoonPhase(julianDay: julianDay)
    XCTAssertNil(possibleMajorPhase)

    date = TinyMoon.formatDate(year: 2024, month: 10, day: 18)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    possibleMajorPhase = TinyMoon.Moon.dayIncludesMajorMoonPhase(julianDay: julianDay)
    XCTAssertNil(possibleMajorPhase)
  }

  func test_moon_moonPhase() {
    var date = TinyMoon.formatDate(year: 2024, month: 10, day: 16)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var phaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay).phase
    var moonPhase = TinyMoon.Moon.moonPhase(julianDay: julianDay, phaseFraction: phaseFraction)
    XCTAssertEqual(moonPhase, .waxingGibbous)

    date = TinyMoon.formatDate(year: 2024, month: 10, day: 17)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    phaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay).phase
    moonPhase = TinyMoon.Moon.moonPhase(julianDay: julianDay, phaseFraction: phaseFraction)
    XCTAssertEqual(moonPhase, .fullMoon)

    date = TinyMoon.formatDate(year: 2024, month: 10, day: 18)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    phaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay).phase
    moonPhase = TinyMoon.Moon.moonPhase(julianDay: julianDay, phaseFraction: phaseFraction)
    XCTAssertEqual(moonPhase, .waningGibbous)
  }
}

import XCTest
@testable import TinyMoon

final class TinyMoonTests: XCTestCase {

  let utcTimeZone = TimeTestHelper.TimeZoneOption.createTimeZone(timeZone: .utc)
  let pacificTimeZone = TimeTestHelper.TimeZoneOption.createTimeZone(timeZone: .pacific)

  func test_moon_daysUntilFullMoon() {
    // Full Moon at Jun 22  01:07
    var date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 20)
    var daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 2)

    date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 21)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)

    date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 22)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 0)

    // Full Moon at Sep 18  02:34
    date = TimeTestHelper.formatDate(year: 2024, month: 09, day: 12)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 6)

    date = TimeTestHelper.formatDate(year: 2024, month: 09, day: 17)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)

    // Full Moon at Jan 25  17:54
    date = TimeTestHelper.formatDate(year: 2024, month: 01, day: 20)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 5)

    date = TimeTestHelper.formatDate(year: 2024, month: 01, day: 24)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)

    date = TimeTestHelper.formatDate(year: 2024, month: 01, day: 25)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 0)

    // Full Moon at Nov 15  21:28
    date = TimeTestHelper.formatDate(year: 2024, month: 11, day: 13)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 2)

    date = TimeTestHelper.formatDate(year: 2024, month: 11, day: 14)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)

    date = TimeTestHelper.formatDate(year: 2024, month: 11, day: 15)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 0)

    // Full Moon at Feb 24  12:30
    date = TimeTestHelper.formatDate(year: 2024, month: 01, day: 25)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 0)

    date = TimeTestHelper.formatDate(year: 2024, month: 01, day: 26)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 29)

    date = TimeTestHelper.formatDate(year: 2024, month: 02, day: 23)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)

    date = TimeTestHelper.formatDate(year: 2024, month: 02, day: 24)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 0)
  }

  func test_moon_daysUntilNewMoon() {
    // New Moon at May 8  03:21
    var date = TimeTestHelper.formatDate(year: 2024, month: 05, day: 06)
    var daysTill = TinyMoon.Moon.daysUntilNewMoon(
      moonPhase: .waningGibbous,
      date: date,
      timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 2)

    date = TimeTestHelper.formatDate(year: 2024, month: 05, day: 07)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)

    // New Moon at Jun 6  12:37 UTC
    date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 03)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 3)

    date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 04)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 2)

    date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 05)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)

    date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 06)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 0)

    // New Moon at Jul 5  22:57 UTC
    date = TimeTestHelper.formatDate(year: 2024, month: 07, day: 02)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 3)

    date = TimeTestHelper.formatDate(year: 2024, month: 07, day: 03)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 2)

    date = TimeTestHelper.formatDate(year: 2024, month: 07, day: 04)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)

    date = TimeTestHelper.formatDate(year: 2024, month: 07, day: 05)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 0)

    // New Moon at Dec 1  06:21
    date = TimeTestHelper.formatDate(year: 2024, month: 11, day: 24)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 7)

    // New Moon at Nov 1  12:47
    date = TimeTestHelper.formatDate(year: 2024, month: 10, day: 31)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)

    date = TimeTestHelper.formatDate(year: 2024, month: 11, day: 1)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous,date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 0)

    date = TimeTestHelper.formatDate(year: 2024, month: 10, day: 03)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 29)
  }

  func test_moon_uniquePhases_utcTimeZone() {
    var emojisByMonth = [MonthTestHelper.Month: Int]()

    for month in MonthTestHelper.Month.allCases {
      let moons = MoonTestHelper.moonObjectsForMonth(month: month, year: 2024, timeZone: utcTimeZone)
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

    for month in MonthTestHelper.Month.allCases {
      switch month {
      case .may, .december:
        XCTAssertEqual(emojisByMonth[month], 5)
      default:
        XCTAssertEqual(emojisByMonth[month], 4)
      }
    }
  }

  func test_moon_startAndEndOfJulianDay() {
    var date = TimeTestHelper.formatDate(year: 2024, month: 01, day: 11, hour: 00, timeZone: utcTimeZone)
    var (start, end) = TinyMoon.Moon.julianStartAndEndOfDay(date: date, timeZone: utcTimeZone)
    XCTAssertEqual(start, 2460320.5)
    XCTAssertEqual(end, 2460321.5)

    date = TimeTestHelper.formatDate(year: 2024, month: 01, day: 11, hour: 06, timeZone: utcTimeZone)
    (start, end) = TinyMoon.Moon.julianStartAndEndOfDay(date: date, timeZone: utcTimeZone)
    XCTAssertEqual(start, 2460320.5)
    XCTAssertEqual(end, 2460321.5)

    date = TimeTestHelper.formatDate(year: 2024, month: 01, day: 11, hour: 09, timeZone: utcTimeZone)
    (start, end) = TinyMoon.Moon.julianStartAndEndOfDay(date: date, timeZone: utcTimeZone)
    XCTAssertEqual(start, 2460320.5)
    XCTAssertEqual(end, 2460321.5)

    date = TimeTestHelper.formatDate(year: 2024, month: 01, day: 11, hour: 12, timeZone: utcTimeZone)
    (start, end) = TinyMoon.Moon.julianStartAndEndOfDay(date: date, timeZone: utcTimeZone)
    XCTAssertEqual(start, 2460320.5)
    XCTAssertEqual(end, 2460321.5)

    date = TimeTestHelper.formatDate(year: 2024, month: 01, day: 11, hour: 23, minute: 18, timeZone: utcTimeZone)
    (start, end) = TinyMoon.Moon.julianStartAndEndOfDay(date: date, timeZone: utcTimeZone)
    XCTAssertEqual(start, 2460320.5)
    XCTAssertEqual(end, 2460321.5)

    date = TimeTestHelper.formatDate(year: 2024, month: 01, day: 12, hour: 05, timeZone: utcTimeZone)
    (start, end) = TinyMoon.Moon.julianStartAndEndOfDay(date: date, timeZone: utcTimeZone)
    XCTAssertEqual(start, 2460321.5)
    XCTAssertEqual(end, 2460322.5)
  }

  func test_moon_majorMoonPhaseInRange() throws {
    var date = TimeTestHelper.formatDate(year: 2024, month: 04, day: 22, timeZone: utcTimeZone)
    var (start, end) = TinyMoon.Moon.julianStartAndEndOfDay(date: date, timeZone: utcTimeZone)
    var startMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: start).phase
    var endMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: end).phase
    XCTAssertNil(TinyMoon.Moon.majorMoonPhaseInRange(start: startMoonPhaseFraction, end: endMoonPhaseFraction))

    date = TimeTestHelper.formatDate(year: 2024, month: 04, day: 23, timeZone: utcTimeZone)
    (start, end) = TinyMoon.Moon.julianStartAndEndOfDay(date: date, timeZone: utcTimeZone)
    startMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: start).phase
    endMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: end).phase
    var fullMoon = try XCTUnwrap(TinyMoon.Moon.majorMoonPhaseInRange(start: startMoonPhaseFraction, end: endMoonPhaseFraction))
    XCTAssertEqual(fullMoon, .fullMoon)

    date = TimeTestHelper.formatDate(year: 2024, month: 04, day: 24, timeZone: utcTimeZone)
    (start, end) = TinyMoon.Moon.julianStartAndEndOfDay(date: date, timeZone: utcTimeZone)
    startMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: start).phase
    endMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: end).phase
    XCTAssertNil(TinyMoon.Moon.majorMoonPhaseInRange(start: startMoonPhaseFraction, end: endMoonPhaseFraction))

    // Full Moon
    date = TimeTestHelper.formatDate(year: 2024, month: 01, day: 25, timeZone: utcTimeZone)
    (start, end) = TinyMoon.Moon.julianStartAndEndOfDay(date: date, timeZone: utcTimeZone)
    startMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: start).phase
    endMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: end).phase
    fullMoon = try XCTUnwrap(TinyMoon.Moon.majorMoonPhaseInRange(start: startMoonPhaseFraction, end: endMoonPhaseFraction))
    XCTAssertEqual(fullMoon, .fullMoon)

    date = TimeTestHelper.formatDate(year: 2024, month: 1, day: 26, timeZone: utcTimeZone)
    (start, end) = TinyMoon.Moon.julianStartAndEndOfDay(date: date, timeZone: utcTimeZone)
    startMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: start).phase
    endMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: end).phase
    XCTAssertNil(TinyMoon.Moon.majorMoonPhaseInRange(start: startMoonPhaseFraction, end: endMoonPhaseFraction))

    // New Moon
    date = TimeTestHelper.formatDate(year: 2024, month: 10, day: 02, hour: 00, timeZone: utcTimeZone)
    (start, end) = TinyMoon.Moon.julianStartAndEndOfDay(date: date, timeZone: utcTimeZone)
    startMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: start).phase
    endMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: end).phase
    let newMoon = try XCTUnwrap(TinyMoon.Moon.majorMoonPhaseInRange(start: startMoonPhaseFraction, end: endMoonPhaseFraction))
    XCTAssertEqual(newMoon, .newMoon)

    date = TimeTestHelper.formatDate(year: 2024, month: 10, day: 03, hour: 00, timeZone: utcTimeZone)
    (start, end) = TinyMoon.Moon.julianStartAndEndOfDay(date: date, timeZone: utcTimeZone)
    startMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: start).phase
    endMoonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: end).phase
    XCTAssertNil(TinyMoon.Moon.majorMoonPhaseInRange(start: startMoonPhaseFraction, end: endMoonPhaseFraction))
  }

  func test_moon_dayIncludesMajorMoonPhase() throws {
    var date = TimeTestHelper.formatDate(year: 2024, month: 10, day: 17)
    var possibleMajorPhase = TinyMoon.Moon.dayIncludesMajorMoonPhase(
      date: date,
      timeZone: utcTimeZone)
    let majorPhase = try XCTUnwrap(possibleMajorPhase)
    XCTAssertEqual(majorPhase, .fullMoon)

    date = TimeTestHelper.formatDate(year: 2024, month: 10, day: 16)
    possibleMajorPhase = TinyMoon.Moon.dayIncludesMajorMoonPhase(date: date, timeZone: utcTimeZone)
    XCTAssertNil(possibleMajorPhase)

    date = TimeTestHelper.formatDate(year: 2024, month: 10, day: 18)
    possibleMajorPhase = TinyMoon.Moon.dayIncludesMajorMoonPhase(
      date: date,
      timeZone: utcTimeZone)
    XCTAssertNil(possibleMajorPhase)
  }

  func test_moon_moonPhase() {
    var date = TimeTestHelper.formatDate(year: 2024, month: 10, day: 16)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var phaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay).phase
    var moonPhase = TinyMoon.Moon.moonPhase(phaseFraction: phaseFraction, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(moonPhase, .waxingGibbous)

    date = TimeTestHelper.formatDate(year: 2024, month: 10, day: 17)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    phaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay).phase
    moonPhase = TinyMoon.Moon.moonPhase(phaseFraction: phaseFraction, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(moonPhase, .fullMoon)

    date = TimeTestHelper.formatDate(year: 2024, month: 10, day: 18)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    phaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay).phase
    moonPhase = TinyMoon.Moon.moonPhase(phaseFraction: phaseFraction, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(moonPhase, .waningGibbous)
  }

  func test_moon_timezone_support() {
    let utcTimeZone = TimeTestHelper.TimeZoneOption.createTimeZone(timeZone: .utc)
    let pacificTimeZone = TimeTestHelper.TimeZoneOption.createTimeZone(timeZone: .pacific)
    let tokyoTimeZone = TimeTestHelper.TimeZoneOption.createTimeZone(timeZone: .tokyo)

    // First Quarter Moon on
    //  - Pacific:  Jun 13  10:18 pm
    //  - UTC:      Jun 14  05:18
    var date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 13, timeZone: pacificTimeZone)
    var moon = TinyMoon.calculateMoonPhase(date, timeZone: pacificTimeZone)
    XCTAssertEqual(moon.moonPhase, .firstQuarter)

    date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 14, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertEqual(moon.moonPhase, .firstQuarter)

    date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 13, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertNotEqual(moon.moonPhase, .firstQuarter)

    date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 14, timeZone: pacificTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: pacificTimeZone)
    XCTAssertNotEqual(moon.moonPhase, .firstQuarter)

    // New Moon on
    //  - Pacific:  Jun 6  05:37
    //  - UTC:      Jun 6  12:37
    date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 06, timeZone: pacificTimeZone)
    print(date)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: pacificTimeZone)
    XCTAssertEqual(moon.moonPhase, .newMoon)

    date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 06, timeZone: utcTimeZone)
    print(date)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertEqual(moon.moonPhase, .newMoon)

    // Full Moon on
    //  - Pacific:  Jun 21  18:07 pm
    //  - UTC:      Jun 22  01:07
    date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 21, timeZone: pacificTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: pacificTimeZone)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.fullMoonName, "Strawberry Moon")

    date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 22, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.fullMoonName, "Strawberry Moon")

    date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 22, timeZone: pacificTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: pacificTimeZone)
    XCTAssertNotEqual(moon.moonPhase, .fullMoon)
    XCTAssertNil(moon.fullMoonName)

    date = TimeTestHelper.formatDate(year: 2024, month: 06, day: 21, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertNotEqual(moon.moonPhase, .fullMoon)
    XCTAssertNil(moon.fullMoonName)


    // Full Moon on
    //  - UTC:    Aug 19  18:25
    //  - Tokyo:  Aug 20  03:25
    date = TimeTestHelper.formatDate(year: 2024, month: 08, day: 19, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.fullMoonName, "Sturgeon Moon")

    date = TimeTestHelper.formatDate(year: 2024, month: 08, day: 20, timeZone: tokyoTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: tokyoTimeZone)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.fullMoonName, "Sturgeon Moon")

    date = TimeTestHelper.formatDate(year: 2024, month: 08, day: 19, timeZone: tokyoTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: tokyoTimeZone)
    XCTAssertNotEqual(moon.moonPhase, .fullMoon)
    XCTAssertNil(moon.fullMoonName)

    date = TimeTestHelper.formatDate(year: 2024, month: 08, day: 20, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertNotEqual(moon.moonPhase, .fullMoon)
    XCTAssertNil(moon.fullMoonName)

    // Full Moon on
    //  - UTC:  Nov 15 21:28
    //  - Tokyo Nov 16 06:28
    date = TimeTestHelper.formatDate(year: 2024, month: 11, day: 15, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.fullMoonName, "Beaver Moon")

    date = TimeTestHelper.formatDate(year: 2024, month: 11, day: 16, timeZone: tokyoTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: tokyoTimeZone)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.fullMoonName, "Beaver Moon")

    date = TimeTestHelper.formatDate(year: 2024, month: 11, day: 16, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertNotEqual(moon.moonPhase, .fullMoon)
    XCTAssertNil(moon.fullMoonName)

    date = TimeTestHelper.formatDate(year: 2024, month: 11, day: 15, timeZone: tokyoTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: tokyoTimeZone)
    XCTAssertNotEqual(moon.moonPhase, .fullMoon)
    XCTAssertNil(moon.fullMoonName)
  }

  // These following moon phases happen within 5 hours of midnight, so these tests aim to check that the phase is calculated correctly and lands on the correct day
  func test_moon_marginOfError() {
    // 4 full moon (3 PST / 1 UTC)
    // 5 new moon (4 PST / 1 UTC)
    // 1 last quarter (1 UTC)
    // --------------
    // 10 total (7 PST / 3 UTC)

    // MARK: - PST margin of error tests
    // Values from https://www.timeanddate.com/moon/phases/usa/portland-or

    // Full moon on 2/24/2024 @ 04:30 PST
    var date = TimeTestHelper.formatDate(year: 2024, month: 2, day: 24, hour: 4, minute: 30, timeZone: pacificTimeZone)
    var moon = TinyMoon.calculateMoonPhase(date, timeZone: pacificTimeZone)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.fullMoonName, "Snow Moon")

    // New moon on 3/10/2024 @ 01:00 PST
    date = TimeTestHelper.formatDate(year: 2024, month: 3, day: 10, hour: 1, minute: 0, timeZone: pacificTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: pacificTimeZone)
    XCTAssertEqual(moon.moonPhase, .newMoon)

    // Full moon on 3/25/2024 @ 00:00 PST
    date = TimeTestHelper.formatDate(year: 2024, month: 3, day: 25, hour: 0, minute: 0, timeZone: pacificTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: pacificTimeZone)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.fullMoonName, "Worm Moon")

    // New moon on 3/10/2024 @ 01:00 PST
    date = TimeTestHelper.formatDate(year: 2024, month: 3, day: 10, hour: 1, minute: 0, timeZone: pacificTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: pacificTimeZone)
    XCTAssertEqual(moon.moonPhase, .newMoon)

    // New moon on 8/4/2024 @ 04:13 PST
    date = TimeTestHelper.formatDate(year: 2024, month: 8, day: 4, hour: 4, minute: 13, timeZone: pacificTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: pacificTimeZone)
    XCTAssertEqual(moon.moonPhase, .newMoon)

    // New moon on 11/30/2024 @ 22:21 PST
    date = TimeTestHelper.formatDate(year: 2024, month: 11, day: 30, hour: 22, minute: 21, timeZone: pacificTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: pacificTimeZone)
    XCTAssertEqual(moon.moonPhase, .newMoon)

    // Full moon on 12/15/2024 @ 01:01 PST
    date = TimeTestHelper.formatDate(year: 2024, month: 12, day: 15, hour: 1, minute: 01, timeZone: pacificTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: pacificTimeZone)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.fullMoonName, "Cold Moon")

    // MARK: - UTC margin of error tests
    // Values from https://www.timeanddate.com/moon/phases/timezone/utc

    // Last Quarter moon on 4/2/2024 @ 03:14 UTC
    date = TimeTestHelper.formatDate(year: 2024, month: 4, day: 2, hour: 3, minute: 14, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertEqual(moon.moonPhase, .lastQuarter)

    // Full moon on 4/23/2024 @ 23:48 UTC
    date = TimeTestHelper.formatDate(year: 2024, month: 4, day: 23, hour: 23, minute: 48, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.fullMoonName, "Pink Moon")

    // New moon on 9/3/2024 @ 01:55 UTC
    date = TimeTestHelper.formatDate(year: 2024, month: 9, day: 3, hour: 1, minute: 55, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertEqual(moon.moonPhase, .newMoon)
  }

  func test_debug() {
    let years = [2032, 2031, 2030, 2029, 2028, 2027, 2026, 2025, 2024, 2023, 2022, 2021, 2020, 2019, 2018, 2017, 2016]
    for tzCase in TimeTestHelper.TimeZoneOption.allCases {
      print("\n:::")
      print(tzCase)
      let timezone = TimeTestHelper.TimeZoneOption.createTimeZone(timeZone: tzCase)
      for year in years {
        let moonsInYear = MonthTestHelper.Month.allCases.map { month in
          MoonTestHelper.moonObjectsForMonth(month: month, year: year, timeZone: timezone)
        }
        for month in moonsInYear {
          for moon in month {
            switch moon.moonPhase {
            case .fullMoon:
              XCTAssertNotNil(moon.fullMoonName)
              print(moon.emoji, moon.date, moon.moonPhase, moon.fullMoonName!) // Force unwrap will fail as well
            default:
              continue
            }
          }
        }
      }
    }
  }
}

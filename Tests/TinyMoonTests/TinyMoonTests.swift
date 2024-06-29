import XCTest
@testable import TinyMoon

final class TinyMoonTests: XCTestCase {

  func test_moon_daysUntilFullMoon() {
    let utcTimeZone = TinyMoon.TimeZoneOption.createTimeZone(timeZone: .utc)

    // Full Moon at Jun 22  01:07
    var date = TinyMoon.formatDate(year: 2024, month: 06, day: 20)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 2)

    date = TinyMoon.formatDate(year: 2024, month: 06, day: 21)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)

    date = TinyMoon.formatDate(year: 2024, month: 06, day: 22)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 0)

    // Full Moon at Sep 18  02:34
    date = TinyMoon.formatDate(year: 2024, month: 09, day: 12)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 6)

    date = TinyMoon.formatDate(year: 2024, month: 09, day: 17)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)

    // Full Moon at Jan 25  17:54
    date = TinyMoon.formatDate(year: 2024, month: 01, day: 20)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 5)

    date = TinyMoon.formatDate(year: 2024, month: 01, day: 24)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)

    date = TinyMoon.formatDate(year: 2024, month: 01, day: 25)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 0)

    // Full Moon at Nov 15  21:28
    date = TinyMoon.formatDate(year: 2024, month: 11, day: 13)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 2)

    date = TinyMoon.formatDate(year: 2024, month: 11, day: 14)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)

    date = TinyMoon.formatDate(year: 2024, month: 11, day: 15)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 0)

    // Full Moon at Feb 24  12:30
    date = TinyMoon.formatDate(year: 2024, month: 01, day: 25)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 0)

    date = TinyMoon.formatDate(year: 2024, month: 01, day: 26)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 29)

    date = TinyMoon.formatDate(year: 2024, month: 02, day: 23)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)

    date = TinyMoon.formatDate(year: 2024, month: 02, day: 24)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilFullMoon(moonPhase: .newMoon, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 0)
  }

  func test_moon_daysUntilNewMoon() {
    let utcTimeZone = TinyMoon.TimeZoneOption.createTimeZone(timeZone: .utc)

    // New Moon at May 8  03:21
    var date = TinyMoon.formatDate(year: 2024, month: 05, day: 06)
    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    var daysTill = TinyMoon.Moon.daysUntilNewMoon(
      moonPhase: .waningGibbous,
      julianDay: julianDay,
      date: date,
      timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 2)

    date = TinyMoon.formatDate(year: 2024, month: 05, day: 07)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)

    // New Moon at Jun 6  12:37 UTC
    date = TinyMoon.formatDate(year: 2024, month: 06, day: 03)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 3)

    date = TinyMoon.formatDate(year: 2024, month: 06, day: 04)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 2)

    date = TinyMoon.formatDate(year: 2024, month: 06, day: 05)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)

    date = TinyMoon.formatDate(year: 2024, month: 06, day: 06)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 0)

    // New Moon at Jul 5  22:57 UTC
    date = TinyMoon.formatDate(year: 2024, month: 07, day: 02)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 3)

    date = TinyMoon.formatDate(year: 2024, month: 07, day: 03)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 2)

    date = TinyMoon.formatDate(year: 2024, month: 07, day: 04)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)
    
    date = TinyMoon.formatDate(year: 2024, month: 07, day: 05)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 0)

    // New Moon at Dec 1  06:21
    date = TinyMoon.formatDate(year: 2024, month: 11, day: 24)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 7)

    // New Moon at Nov 1  12:47
    date = TinyMoon.formatDate(year: 2024, month: 10, day: 31)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 1)

    date = TinyMoon.formatDate(year: 2024, month: 11, day: 1)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 0)

    date = TinyMoon.formatDate(year: 2024, month: 10, day: 03)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    daysTill = TinyMoon.Moon.daysUntilNewMoon(moonPhase: .waningGibbous, julianDay: julianDay, date: date, timeZone: utcTimeZone)
    XCTAssertEqual(daysTill, 29)
  }

  func test_moon_uniquePhases() {
    let utcTimeZone = TinyMoon.TimeZoneOption.createTimeZone(timeZone: .utc)

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
    // HAVE to add TIMEZONE
    var possibleMajorPhase = TinyMoon.Moon.dayIncludesMajorMoonPhase(
      julianDay: julianDay,
      date: date,
      timeZone: TinyMoon.TimeZoneOption.createTimeZone(timeZone: .utc))
    let majorPhase = try XCTUnwrap(possibleMajorPhase)
    XCTAssertEqual(majorPhase, .fullMoon)

    date = TinyMoon.formatDate(year: 2024, month: 10, day: 16)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    possibleMajorPhase = TinyMoon.Moon.dayIncludesMajorMoonPhase(julianDay: julianDay, date: date)
    XCTAssertNil(possibleMajorPhase)

    date = TinyMoon.formatDate(year: 2024, month: 10, day: 18)
    julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
    possibleMajorPhase = TinyMoon.Moon.dayIncludesMajorMoonPhase(
      julianDay: julianDay,
      date: date,
      timeZone: TinyMoon.TimeZoneOption.createTimeZone(timeZone: .utc))
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

  func test_moon_timezone_support() {
    let utcTimeZone = TinyMoon.TimeZoneOption.createTimeZone(timeZone: .utc)
    let pacificTimeZone = TinyMoon.TimeZoneOption.createTimeZone(timeZone: .pacific)
    let tokyoTimeZone = TinyMoon.TimeZoneOption.createTimeZone(timeZone: .tokyo)

    // First Quarter Moon on
    //  - Pacific:  Jun 13  10:18 pm
    //  - UTC:      Jun 14  05:18
    var date = TinyMoon.formatDate(year: 2024, month: 06, day: 13, timeZone: pacificTimeZone)
    var moon = TinyMoon.calculateMoonPhase(date, timeZone: pacificTimeZone)
    XCTAssertEqual(moon.moonPhase, .firstQuarter)

    date = TinyMoon.formatDate(year: 2024, month: 06, day: 14, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertEqual(moon.moonPhase, .firstQuarter)

    date = TinyMoon.formatDate(year: 2024, month: 06, day: 13, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertNotEqual(moon.moonPhase, .firstQuarter)

    date = TinyMoon.formatDate(year: 2024, month: 06, day: 14, timeZone: pacificTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: pacificTimeZone)
    XCTAssertNotEqual(moon.moonPhase, .firstQuarter)

    // New Moon on
    //  - Pacific:  Jun 6  05:37
    //  - UTC:      Jun 6  12:37
    date = TinyMoon.formatDate(year: 2024, month: 06, day: 06, timeZone: pacificTimeZone)
    print(date)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: pacificTimeZone)
    XCTAssertEqual(moon.moonPhase, .newMoon)

    date = TinyMoon.formatDate(year: 2024, month: 06, day: 06, timeZone: utcTimeZone)
    print(date)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertEqual(moon.moonPhase, .newMoon)

    // Full Moon on
    //  - Pacific:  Jun 21  18:07 pm
    //  - UTC:      Jun 22  01:07
    date = TinyMoon.formatDate(year: 2024, month: 06, day: 21, timeZone: pacificTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: pacificTimeZone)
    XCTAssertEqual(moon.moonPhase, .fullMoon)

    date = TinyMoon.formatDate(year: 2024, month: 06, day: 22, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertEqual(moon.moonPhase, .fullMoon)

    date = TinyMoon.formatDate(year: 2024, month: 06, day: 22, timeZone: pacificTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: pacificTimeZone)
    XCTAssertNotEqual(moon.moonPhase, .fullMoon)

    date = TinyMoon.formatDate(year: 2024, month: 06, day: 21, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertNotEqual(moon.moonPhase, .fullMoon)


    // Full Moon on
    //  - UTC:    Aug 19  18:25
    //  - Tokyo:  Aug 20  03:25
    date = TinyMoon.formatDate(year: 2024, month: 08, day: 19, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertEqual(moon.moonPhase, .fullMoon)

    date = TinyMoon.formatDate(year: 2024, month: 08, day: 20, timeZone: tokyoTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: tokyoTimeZone)
    XCTAssertEqual(moon.moonPhase, .fullMoon)

    date = TinyMoon.formatDate(year: 2024, month: 08, day: 19, timeZone: tokyoTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: tokyoTimeZone)
    XCTAssertNotEqual(moon.moonPhase, .fullMoon)

    date = TinyMoon.formatDate(year: 2024, month: 08, day: 20, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertNotEqual(moon.moonPhase, .fullMoon)

    // Full Moon on
    //  - UTC:  Nov 15 21:28
    //  - Tokyo Nov 16 06:28
    date = TinyMoon.formatDate(year: 2024, month: 11, day: 15, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertEqual(moon.moonPhase, .fullMoon)

    date = TinyMoon.formatDate(year: 2024, month: 11, day: 16, timeZone: tokyoTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: tokyoTimeZone)
    XCTAssertEqual(moon.moonPhase, .fullMoon)

    date = TinyMoon.formatDate(year: 2024, month: 11, day: 16, timeZone: utcTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: utcTimeZone)
    XCTAssertNotEqual(moon.moonPhase, .fullMoon)

    date = TinyMoon.formatDate(year: 2024, month: 11, day: 15, timeZone: tokyoTimeZone)
    moon = TinyMoon.calculateMoonPhase(date, timeZone: tokyoTimeZone)
    XCTAssertNotEqual(moon.moonPhase, .fullMoon)
  }
}

import XCTest
@testable import TinyMoon

final class TinyMoonTests: XCTestCase {

//  func test_moon_daysTillFullMoon() {
//    var date = TinyMoon.formatDate(year: 2024, month: 01, day: 01)
//    var julianDay = TinyMoon.AstronomicalConstant.julianDay(date)
//    var daysTillFullMoon = TinyMoon.Moon.daysTillFullMoon(julianDay: julianDay)
//    print(daysTillFullMoon)
//    MoonTestHelper.prettyPrintMoonCalendar(month: .january, year: 2024)
//
//    let moon = TinyMoon.Moon(date: TinyMoon.formatDate(year: 2024, month: 01, day: 25, hour: 17, minute: 54))
//    MoonTestHelper.prettyPrintMoonObject(moon)
//  }
//
//  func test_moon_daysTillNewMoon() {
//    var date = TinyMoon.formatDate(year: 2024, month: 01, day: 01)
//    var julianDate = TinyMoon.AstronomicalConstant.julianDay(date)
//    var daysTillNewMoon = TinyMoon.Moon.daysTillNewMoon(julianDay: julianDate)
//    XCTAssertEqual(daysTillNewMoon, 10)
//  }
//
//  func test_debug() {
//    let month = MonthTestHelper.Month.january
//    if let range = MonthTestHelper.dayRangeInMonth(month, year: 2024) {
//      for i in range {
//        let moon = TinyMoon.calculateMoonPhase(TinyMoon.formatDate(year: 2024, month: month.rawValue, day: i))
//        MoonTestHelper.prettyPrintMoonObject(moon)
//      }
//    }
//  }

  func test_debug() {
//    for hour in 0...23 {
//      print("hour", hour)
//      let date = TinyMoon.formatDate(year: 2024, month: 01, day: 01, hour: hour)
//      let julianDate = TinyMoon.AstronomicalConstant.julianDay(date)
//      let daysTillNewMoon = TinyMoon.Moon.daysTillNewMoon(julianDay: julianDate)
////      print(daysTillNewMoon)
//    }

//    var date = TinyMoon.formatDate(year: 2024, month: 07, day: 17, hour: 0)
//    var jd = TinyMoon.AstronomicalConstant.julianDay(date)
//    
//    let daysTillNewMoon = TinyMoon.Moon.daysTillFullMoon(julianDay: jd)
//    print("daysTillFullMoon OLD", daysTillNewMoon)

//    TinyMoon.Moon.findTrueFullMoon(from: jd)
//    print("\n:::")
//    date = TinyMoon.formatDate(year: 2024, month: 07, day: 17, hour: 12)
//    jd = TinyMoon.AstronomicalConstant.julianDay(date)
//    TinyMoon.Moon.findTrueFullMoon(from: jd)
//
//    date = TinyMoon.formatDate(year: 2024, month: 06, day: 21, hour: 12)
//    let moon = TinyMoon.Moon(date: date)
//    MoonTestHelper.prettyPrintMoonObject(moon)

    let moons = MoonTestHelper.moonMonth(month: .january, year: 2024)
    for moon in moons {
      MoonTestHelper.prettyPrintMoonObject(moon)
    }

  }
}

// Created by manny_lopez on 6/1/24.
// Copyright © 2024 Airbnb Inc. All rights reserved.

import XCTest
@testable import TinyMoon

final class UTCTests: XCTestCase {

  // MARK: - UTC Tests
  // https://www.timeanddate.com/moon/phases/timezone/utc
  // The following moon phases are the exact times for the four moon phases
  // (new, first quarter, full, and last quarter),  in UTC, for 2024

  // Using `lessPreciseJulianDay`, there are 21/50 correct phases
  // Using `julianDay`, the more precise version, there are 20/50
  // Both julian day functions are both wrong 19 times
  // https://docs.google.com/spreadsheets/d/1G85YZnu_PK8L03QyIzovKdnBmZSOWF_HzTpPYSqJUcU/edit?usp=sharing


  // MARK: New Moon

  func tinyMoon_calculateMoonPhase_newMoonPhase_UTC_2024() {
    var correct = 0.0
    var incorrect = 0.0

    let newMoonEmoji = TinyMoon.MoonPhase.newMoon.emoji

    var date = TinyMoon.formatDate(year: 2024, month: 01, day: 11, hour: 11)
    var moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .newMoon)
    XCTAssertEqual(moon.emoji, newMoonEmoji)
    XCTAssertEqual(moon.daysTillNewMoon, 0)
    if moon.emoji == newMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 02, day: 09, hour: 22)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .newMoon)
    XCTAssertEqual(moon.emoji, newMoonEmoji)
    XCTAssertEqual(moon.daysTillNewMoon, 0)
    if moon.emoji == newMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 03, day: 10)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .newMoon)
    XCTAssertEqual(moon.emoji, newMoonEmoji)
    XCTAssertEqual(moon.daysTillNewMoon, 0)
    if moon.emoji == newMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 04, day: 08, hour: 18)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .newMoon)
    XCTAssertEqual(moon.emoji, newMoonEmoji)
    XCTAssertEqual(moon.daysTillNewMoon, 0)
    if moon.emoji == newMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 05, day: 08)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .newMoon)
    XCTAssertEqual(moon.emoji, newMoonEmoji)
    XCTAssertEqual(moon.daysTillNewMoon, 0)
    if moon.emoji == newMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 06, day: 06)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .newMoon)
    XCTAssertEqual(moon.emoji, newMoonEmoji)
    XCTAssertEqual(moon.daysTillNewMoon, 0)
    if moon.emoji == newMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 07, day: 05, hour: 22)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .newMoon)
    XCTAssertEqual(moon.emoji, newMoonEmoji)
    XCTAssertEqual(moon.daysTillNewMoon, 0)
    if moon.emoji == newMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 08, day: 04)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .newMoon)
    XCTAssertEqual(moon.emoji, newMoonEmoji)
    XCTAssertEqual(moon.daysTillNewMoon, 0)
    if moon.emoji == newMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 09, day: 03)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .newMoon)
    XCTAssertEqual(moon.emoji, newMoonEmoji)
    XCTAssertEqual(moon.daysTillNewMoon, 0)
    if moon.emoji == newMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 10, day: 02, hour: 18)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .newMoon)
    XCTAssertEqual(moon.emoji, newMoonEmoji)
    XCTAssertEqual(moon.daysTillNewMoon, 0)
    if moon.emoji == newMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 11, day: 01)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .newMoon)
    XCTAssertEqual(moon.emoji, newMoonEmoji)
    XCTAssertEqual(moon.daysTillNewMoon, 0)
    if moon.emoji == newMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 12, day: 01)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .newMoon)
    XCTAssertEqual(moon.emoji, newMoonEmoji)
    XCTAssertEqual(moon.daysTillNewMoon, 0)
    if moon.emoji == newMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 12, day: 30, hour: 22)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .newMoon)
    XCTAssertEqual(moon.emoji, newMoonEmoji)
    XCTAssertEqual(moon.daysTillNewMoon, 0)
    if moon.emoji == newMoonEmoji { correct += 1 } else { incorrect += 1 }

    printResults(.newMoon, correct: correct, incorrect: incorrect)
  }

  // MARK: First Quarter

  func tinyMoon_calculateMoonPhase_firstQuarterPhase_UTC_2024() {
    var correct = 0.0
    var incorrect = 0.0

    let firstQuarterEmoji = TinyMoon.MoonPhase.firstQuarter.emoji

    var date = TinyMoon.formatDate(year: 2024, month: 01, day: 18)
    var moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .firstQuarter)
    XCTAssertEqual(moon.emoji, firstQuarterEmoji)
    if moon.emoji == firstQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 02, day: 16, hour: 15)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .firstQuarter)
    XCTAssertEqual(moon.emoji, firstQuarterEmoji)
    if moon.emoji == firstQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 03, day: 17)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .firstQuarter)
    XCTAssertEqual(moon.emoji, firstQuarterEmoji)
    if moon.emoji == firstQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 04, day: 15, hour: 19)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .firstQuarter)
    XCTAssertEqual(moon.emoji, firstQuarterEmoji)
    if moon.emoji == firstQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 05, day: 15)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .firstQuarter)
    XCTAssertEqual(moon.emoji, firstQuarterEmoji)
    if moon.emoji == firstQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 06, day: 14)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .firstQuarter)
    XCTAssertEqual(moon.emoji, firstQuarterEmoji)
    if moon.emoji == firstQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 07, day: 13, hour: 22)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .firstQuarter)
    XCTAssertEqual(moon.emoji, firstQuarterEmoji)
    if moon.emoji == firstQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 08, day: 12)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .firstQuarter)
    XCTAssertEqual(moon.emoji, firstQuarterEmoji)
    if moon.emoji == firstQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 09, day: 11)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .firstQuarter)
    XCTAssertEqual(moon.emoji, firstQuarterEmoji)
    if moon.emoji == firstQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 10, day: 10, hour: 18)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .firstQuarter)
    XCTAssertEqual(moon.emoji, firstQuarterEmoji)
    if moon.emoji == firstQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 11, day: 09)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .firstQuarter)
    XCTAssertEqual(moon.emoji, firstQuarterEmoji)
    if moon.emoji == firstQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 12, day: 08)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .firstQuarter)
    XCTAssertEqual(moon.emoji, firstQuarterEmoji)
    if moon.emoji == firstQuarterEmoji { correct += 1 } else { incorrect += 1 }

    printResults(.firstQuarter, correct: correct, incorrect: incorrect)
  }

  // MARK: Full Moon

  func tinyMoon_calculateMoonPhase_fullMoonPhase_UTC_2024() {
    var correct = 0.0
    var incorrect = 0.0

    let fullMoonEmoji = TinyMoon.MoonPhase.fullMoon.emoji

    var date = TinyMoon.formatDate(year: 2024, month: 01, day: 25, hour: 17)
    var moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.emoji, fullMoonEmoji)
    XCTAssertEqual(moon.daysTillFullMoon, 0)
    if moon.emoji == fullMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 02, day: 24)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.emoji, fullMoonEmoji)
    XCTAssertEqual(moon.daysTillFullMoon, 0)
    if moon.emoji == fullMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 03, day: 25)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.emoji, fullMoonEmoji)
    XCTAssertEqual(moon.daysTillFullMoon, 0)
    if moon.emoji == fullMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 04, day: 23, hour: 23)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.emoji, fullMoonEmoji)
    XCTAssertEqual(moon.daysTillFullMoon, 0)
    if moon.emoji == fullMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 05, day: 23, hour: 13)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.emoji, fullMoonEmoji)
    XCTAssertEqual(moon.daysTillFullMoon, 0)
    if moon.emoji == fullMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 06, day: 22)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.emoji, fullMoonEmoji)
    XCTAssertEqual(moon.daysTillFullMoon, 0)
    if moon.emoji == fullMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 07, day: 21, hour: 10)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.emoji, fullMoonEmoji)
    XCTAssertEqual(moon.daysTillFullMoon, 0)
    if moon.emoji == fullMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 08, day: 19, hour: 18)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.emoji, fullMoonEmoji)
    XCTAssertEqual(moon.daysTillFullMoon, 0)
    if moon.emoji == fullMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 09, day: 18)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.emoji, fullMoonEmoji)
    XCTAssertEqual(moon.daysTillFullMoon, 0)
    if moon.emoji == fullMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 10, day: 17)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.emoji, fullMoonEmoji)
    XCTAssertEqual(moon.daysTillFullMoon, 0)
    if moon.emoji == fullMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 11, day: 15, hour: 21)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.emoji, fullMoonEmoji)
    XCTAssertEqual(moon.daysTillFullMoon, 0)
    if moon.emoji == fullMoonEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 12, day: 15)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .fullMoon)
    XCTAssertEqual(moon.emoji, fullMoonEmoji)
    XCTAssertEqual(moon.daysTillFullMoon, 0)
    if moon.emoji == fullMoonEmoji { correct += 1 } else { incorrect += 1 }

    printResults(.fullMoon, correct: correct, incorrect: incorrect)
  }

  // MARK: Last Quarter

  func tinyMoon_calculateMoonPhase_lastQuarterPhase_UTC_2024() {
    var correct = 0.0
    var incorrect = 0.0

    let lastQuarterEmoji = TinyMoon.MoonPhase.lastQuarter.emoji

    var date = TinyMoon.formatDate(year: 2024, month: 01, day: 04)
    var moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .lastQuarter)
    XCTAssertEqual(moon.emoji, lastQuarterEmoji)
    if moon.emoji == lastQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 02, day: 02, hour: 23)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .lastQuarter)
    XCTAssertEqual(moon.emoji, lastQuarterEmoji)
    if moon.emoji == lastQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 03, day: 03)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .lastQuarter)
    XCTAssertEqual(moon.emoji, lastQuarterEmoji)
    if moon.emoji == lastQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 04, day: 02)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .lastQuarter)
    XCTAssertEqual(moon.emoji, lastQuarterEmoji)
    if moon.emoji == lastQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 05, day: 01)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .lastQuarter)
    XCTAssertEqual(moon.emoji, lastQuarterEmoji)
    if moon.emoji == lastQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 05, day: 30, hour: 17)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .lastQuarter)
    XCTAssertEqual(moon.emoji, lastQuarterEmoji)
    if moon.emoji == lastQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 06, day: 28, hour: 21)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .lastQuarter)
    XCTAssertEqual(moon.emoji, lastQuarterEmoji)
    if moon.emoji == lastQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 07, day: 28)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .lastQuarter)
    XCTAssertEqual(moon.emoji, lastQuarterEmoji)
    if moon.emoji == lastQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 08, day: 26)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .lastQuarter)
    XCTAssertEqual(moon.emoji, lastQuarterEmoji)
    if moon.emoji == lastQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 09, day: 24, hour: 18)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .lastQuarter)
    XCTAssertEqual(moon.emoji, lastQuarterEmoji)
    if moon.emoji == lastQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 10, day: 24)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .lastQuarter)
    XCTAssertEqual(moon.emoji, lastQuarterEmoji)
    if moon.emoji == lastQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 11, day: 23)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .lastQuarter)
    XCTAssertEqual(moon.emoji, lastQuarterEmoji)
    if moon.emoji == lastQuarterEmoji { correct += 1 } else { incorrect += 1 }

    date = TinyMoon.formatDate(year: 2024, month: 12, day: 22, hour: 22)
    moon = TinyMoon.calculateMoonPhase(date)
    XCTAssertEqual(moon.moonPhase, .lastQuarter)
    XCTAssertEqual(moon.emoji, lastQuarterEmoji)
    if moon.emoji == lastQuarterEmoji { correct += 1 } else { incorrect += 1 }

    printResults(.lastQuarter, correct: correct, incorrect: incorrect)
  }

  private func printResults(_ moonPhase: TinyMoon.MoonPhase, correct: Double, incorrect: Double) {
    let results = """

    \(moonPhase)
      "correct: \(correct)"
      "incorrect: \(incorrect)"
      % correct: \((correct / (correct + incorrect) * 100).rounded())%
    """
    print(results)
  }

}

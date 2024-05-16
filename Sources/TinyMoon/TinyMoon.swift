import Foundation

public struct Moon {
  init(moonPhase: MoonPhase, lunarDay: Double, date: Date) {
    self.moonPhase = moonPhase
    self.name = moonPhase.rawValue
    self.emoji = moonPhase.emoji
    self.lunarDay = lunarDay
    self.date = date
  }

  public let moonPhase: MoonPhase
  public let name: String
  public let emoji: String
  public let lunarDay: Double
  public let date: Date

  public var daysTillFullMoon: Int {
    let wholeLunarDay = lround(lunarDay)
    if wholeLunarDay > 15 {
      return 29 - wholeLunarDay + 15
    } else {
      return 15 - wholeLunarDay
    }
  }

  public func isFullMoon() -> Bool {
    switch moonPhase {
    case .fullMoon: true
    default: false
    }
  }

  public var fullMoonName: String? {
    if isFullMoon() {
      let calendar = Calendar.current
      let components = calendar.dateComponents([.month], from: date)
      if let month = components.month {
        return fullMoonName(month: month)
      }
    }
    return nil
  }

  private func fullMoonName(month: Int) -> String? {
    switch month {
    case 1: "Wolf Moon"
    case 2: "Snow Moon"
    case 3: "Worm Moon"
    case 4: "Pink Moon"
    case 5: "Flower Moon"
    case 6: "Strawberry Moon"
    case 7: "Buck Moon"
    case 8: "Sturgeon Moon"
    case 9: "Harvest Moon"
    case 10: "Hunter's Moon"
    case 11: "Beaver Moon"
    case 12: "Cold Moon"
    default: nil
    }
  }
}

public enum MoonPhase: String {
  case newMoon          = "New Moon"
  case waxingCrescent   = "Waxing Crescent"
  case firstQuarter     = "First Quarter"
  case waxingGibbous    = "Waxing Gibbous"
  case fullMoon         = "Full Moon"
  case waningGibbous    = "Waning Gibbous"
  case lastQuarter      = "Last Quarter"
  case waningCrescent   = "Waning Crescent"

  var emoji: String {
    switch self {
    case .newMoon:
      "\u{1F311}" // 🌑
    case .waxingCrescent:
      "\u{1F312}" // 🌒
    case .firstQuarter:
      "\u{1F313}" // 🌓
    case .waxingGibbous:
      "\u{1F314}" // 🌔
    case .fullMoon:
      "\u{1F315}" // 🌕
    case .waningGibbous:
      "\u{1F316}" // 🌖
    case .lastQuarter:
      "\u{1F317}" // 🌗
    case .waningCrescent:
      "\u{1F318}" // 🌘
    }
  }
}

public struct TinyMoon {
  public init() { }
  public func calculateMoonPhase(_ date: Date = Date()) -> Moon {
    let synodicMonth = 29.53058770576
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day, .month, .year], from: date)
    guard
      let year = components.year,
      let month = components.month,
      let day = components.day
    else {
      print("Error: Cannot resolve year, month, or day.")
      FileHandle.standardError.write("Error: Cannot resolve year, month, or day".data(using: .utf8)!)
      exit(1)
    }
    // Days between a known new moon date (January 6th, 2000) and the given day
    let dateDifference = julianDay(year: year, month: month, day: day) - julianDay(year: 2000, month: 1, day: 6)
    // Divide by synodic month `29.53058770576`
    let lunarDay = (dateDifference / synodicMonth).truncatingRemainder(dividingBy: 1) * synodicMonth

    let moonPhase = moonPhase(lunarDay: lround(lunarDay))
    let moon = Moon(moonPhase: moonPhase, lunarDay: lunarDay, date: date)
    return moon
  }

  private func moonPhase(lunarDay: Int) -> MoonPhase {
    if lunarDay < 1  {
      return .newMoon
    } else if lunarDay < 7 {
      return .waxingCrescent
    } else if lunarDay < 8 {
      return .firstQuarter
    } else if lunarDay < 15 {
      return .waxingGibbous
    } else if lunarDay < 16 {
      return .fullMoon
    } else if lunarDay < 22 {
      return .waningGibbous
    } else if lunarDay < 23 {
      return .lastQuarter
    } else if lunarDay < 29 {
      return .waningCrescent
    } else {
      return .newMoon
    }
  }

  /// The Julian Day Count is a uniform count of days from a remote epoch in the past and is used for calculating the days between two events.
  /// The Julian day is calculated by combining the contributions from the years, months, and day, taking into account constant offsets and rounding down the result.
  /// https://quasar.as.utexas.edu/BillInfo/JulianDatesG.html
  private func julianDay(year: Int, month: Int, day: Int) -> Double {
    var newYear = year
    var newMonth = month
    if month <= 2 {
      newYear = year - 1
      newMonth = month + 12
    }
    let a = Int(newYear / 100)
    let b = Int(a / 4)
    let c = 2 - a + b
    let e = Int(365.25 * Double(newYear + 4716))
    let f = Int(30.6001 * Double(newMonth + 1))
    return Double(c + day + e + f) - 1524.5
  }
}

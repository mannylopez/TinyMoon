import Foundation

public enum TinyMoon {

  private static var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    formatter.timeZone = TimeZone(identifier: "UTC")
    return formatter
  }

  static func formatDate(
    year: Int,
    month: Int,
    day: Int,
    hour: Int = 00,
    minute: Int = 00) -> Date
  {
    guard let date = TinyMoon.dateFormatter.date(from: "\(year)/\(month)/\(day) \(hour):\(minute)") else {
      fatalError("Invalid date")
    }
    return date
  }

  public static func calculateMoonPhase(_ date: Date = Date()) -> Moon {
    Moon(date: date)
  }

  public struct Moon: Hashable {
    init(date: Date) {
      let julianDay = AstronomicalConstant.julianDay(date)
      let moonPhaseData = AstronomicalConstant.getMoonPhase(julianDay: julianDay)

      self.phaseFraction = moonPhaseData.phase
      self.illuminatedFraction = moonPhaseData.illuminatedFraction
      self.date = date
      self.lunarDay = Moon.lunarDay(for: date)
      self.maxLunarDay = Moon.maxLunarDayInCycle(starting: date)
      self.moonPhase = Moon.moonPhase(lunarDay: Int(floor(lunarDay)))
      self.name = moonPhase.rawValue
      self.emoji = moonPhase.emoji
    }

    /// Represents where the phase is in the current synodic cycle. Varies between `0.0` to `0.99`.
    ///
    /// `0.0` new moon, `0.25` first quarter, `0.5` full moon, `0.75` last
    public let phaseFraction: Double
    /// Illuminated fraction of Moon's disk, between `0.0` and `1.0`.
    ///
    /// `0` indicates a new moon and `1.0` indicates a full moon.
    public let illuminatedFraction: Double
    public let moonPhase: MoonPhase
    public let name: String
    public let emoji: String
    public let lunarDay: Double
    public let maxLunarDay: Double
    public let date: Date
    private var wholeLunarDay: Int {
      Int(floor(lunarDay))
    }

    // Returns `0` if the current `date` is a full moon
    public var daysTillFullMoon: Int {
      if wholeLunarDay > 14 {
        return 29 - wholeLunarDay + 14
      } else {
        return 14 - wholeLunarDay
      }
    }

    // Returns `0` if the current `date` is a new moon
    public var daysTillNewMoon: Int {
      if wholeLunarDay == 0 {
        return 0
      } else {
        let daysTillNextNewMoon = Int(ceil(maxLunarDay)) - wholeLunarDay
        return daysTillNextNewMoon
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

    internal static func lunarDay(for date: Date, usePreciseJulianDay: Bool = false) -> Double {
      let synodicMonth = 29.53058770576

      var calendar = Calendar.current
      calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? calendar.timeZone
      let components = calendar.dateComponents([.year, .month, .day], from: date)

      guard
        let year = components.year,
        let month = components.month,
        let day = components.day
      else {
        print("Error: Cannot resolve year, month, or day.")
        FileHandle.standardError.write("Error: Cannot resolve year, month, or day".data(using: .utf8)!)
        exit(1)
      }

      var dateDifference: Double
      if usePreciseJulianDay {
        // Days between the given day and a known new moon date (January 6th, 2000)
        let knownNewMoonDate = TinyMoon.formatDate(year: 2000, month: 01, day: 06, hour: 18, minute: 13)
        dateDifference = AstronomicalConstant.julianDay(date) - AstronomicalConstant.julianDay(knownNewMoonDate)
      } else {
        // Days between a known new moon date (January 6th, 2000) and the given day
        dateDifference = AstronomicalConstant.lessPreciseJulianDay(year: year, month: month, day: day) - AstronomicalConstant.lessPreciseJulianDay(year: 2000, month: 1, day: 6)
      }
      // Divide by synodic month `29.53058770576`
      let lunarDay = (dateDifference / synodicMonth).truncatingRemainder(dividingBy: 1) * synodicMonth
      return lunarDay
    }

    internal static func maxLunarDayInCycle(starting date: Date) -> Double {
      let maxLunarDay = lunarDay(for: date)
      let calendar = Calendar.current
      if let tomorrow = calendar.date(byAdding: .day, value: 1, to: date) {
        if lunarDay(for: tomorrow) < maxLunarDay {
          return maxLunarDay
        } else {
          return maxLunarDayInCycle(starting: tomorrow)
        }
      }
      return maxLunarDay
    }

    internal static func moonPhase(lunarDay: Int) -> MoonPhase {
      if lunarDay < 1  {
        return .newMoon
      } else if lunarDay < 6 {
        return .waxingCrescent
      } else if lunarDay < 7 {
        return .firstQuarter
      } else if lunarDay < 14 {
        return .waxingGibbous
      } else if lunarDay < 15 {
        return .fullMoon
      } else if lunarDay < 21 {
        return .waningGibbous
      } else if lunarDay < 22 {
        return .lastQuarter
      } else if lunarDay < 30 {
        return .waningCrescent
      } else {
        return .newMoon
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
}

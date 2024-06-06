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
      self.moonPhaseFraction = moonPhaseData.phase
      self.percentIlluminated = moonPhaseData.illuminatedFraction

      self.daysTillFullMoon = Moon.daysTillFullMoon(julianDay: julianDay)
      self.daysTillNewMoon = Moon.daysTillNewMoon(julianDay: julianDay)

      self.date = date
      self.moonPhase = Moon.moonPhase(phase: self.moonPhaseFraction)
      self.name = moonPhase.rawValue
      self.emoji = moonPhase.emoji
    }

    public let percentIlluminated: Double
    ///  Varies between `0.0` to `0.99`.
    ///
    ///  `0.0` new moon, `0.25` first quarter, `0.5` full moon, `0.75` last
    public let moonPhaseFraction: Double
    public let moonPhase: MoonPhase
    public let name: String
    public let emoji: String
    public let date: Date
    /// Returns `0` if the current `date` is a full moon
    public var daysTillFullMoon: Double
    /// Returns `0` if the current `date` is a new moon
    public var daysTillNewMoon: Int

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

    internal static func daysTillFullMoon(julianDay: Double) -> Double {
      var currentJulianDay = julianDay
      var daysTillFullMoon = 0.0
      var phaseFraction = AstronomicalConstant.getMoonPhase(julianDay: currentJulianDay).phase
      var nextDayPhase = Moon.moonPhase(phase: phaseFraction)
//      print("Init phaseFraction", phaseFraction)
      let increment = 0.5

      while nextDayPhase != .fullMoon {
//        print("  nextDayPhase", nextDayPhase)
        currentJulianDay += increment
        daysTillFullMoon += increment
        phaseFraction = AstronomicalConstant.getMoonPhase(julianDay: currentJulianDay).phase
//        print("    phaseFraction", phaseFraction)
        nextDayPhase = Moon.moonPhase(phase: phaseFraction)
      }
//      print("  Final phaseFraction", phaseFraction)
//      print((floor(daysTillFullMoon)))
      return daysTillFullMoon
    }

    internal static func daysTillNewMoon(julianDay: Double) -> Int {
      var currentJulianDay = julianDay
      var daysTillNewMoon = 0.0
      var nextDayPhase = Moon.moonPhase(phase: AstronomicalConstant.getMoonPhase(julianDay: currentJulianDay).phase)
      let increment = 0.5

      while nextDayPhase != .newMoon {
        currentJulianDay += increment
        daysTillNewMoon += increment
        nextDayPhase = Moon.moonPhase(phase: AstronomicalConstant.getMoonPhase(julianDay: currentJulianDay).phase)
      }
      return Int(daysTillNewMoon)
    }

    internal static func findTrueFullMoon(from julianDay: Double) {
      var currentJulianDay = julianDay
      var daysTillFullMoon = 0

      var phaseFraction = AstronomicalConstant.getMoonPhase(julianDay: currentJulianDay).phase

      while phaseFraction < 0.5 {
        print(phaseFraction)
        currentJulianDay += 1
        daysTillFullMoon += 1
        phaseFraction = AstronomicalConstant.getMoonPhase(julianDay: currentJulianDay).phase
      }
      print("finalphaseFraction", phaseFraction)

      print("finished with daysTillFullMoon", daysTillFullMoon)
    }

    internal static func moonPhase(phase: Double) -> MoonPhase {
      let localPhase = Int(floor(phase * 100))
//      print("localPhase", localPhase)
      if localPhase < 2  {
        return .newMoon
      } else if localPhase < 23 {
        return .waxingCrescent
      } else if localPhase < 27 {
        return .firstQuarter
      } else if localPhase < 48 {
        return .waxingGibbous
      } else if localPhase < 52 {
        return .fullMoon
      } else if localPhase < 73 {
        return .waningGibbous
      } else if localPhase < 77 {
        return .lastQuarter
      } else if localPhase < 98 {
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

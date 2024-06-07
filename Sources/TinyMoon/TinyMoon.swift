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
      self.daysTillFullMoon = Moon.daysUntilFullMoon(julianDay: julianDay)
      self.daysTillNewMoon = Moon.daysUntilNewMoon(julianDay: julianDay)
      self.moonPhase = Moon.moonPhase(phaseFraction: phaseFraction)
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
    public let date: Date
    /// Returns `0` if the current `date` is a full moon
    public var daysTillFullMoon: Int
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

    internal static func daysUntilFullMoon(julianDay: Double) -> Int {
      let moonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay).phase
      let moonPhase = TinyMoon.Moon.moonPhase(phaseFraction: moonPhaseFraction)
      if moonPhase == .fullMoon {
        return 0
      } else {
        return 1
      }
    }

    internal static func daysUntilNewMoon(julianDay: Double) -> Int {
      let moonPhaseFraction = TinyMoon.AstronomicalConstant.getMoonPhase(julianDay: julianDay).phase
      let moonPhase = TinyMoon.Moon.moonPhase(phaseFraction: moonPhaseFraction)
      if moonPhase == .newMoon {
        return 0
      } else {
        return 1
      }
    }

    internal static func julianDaysFor24HourPeriod(julianDay: Double) -> [Double] {
      let wholePart = floor(julianDay)
      let fractionalPart = julianDay.truncatingRemainder(dividingBy: 1)
      var julianDays: [Double] = []
      if fractionalPart >= 0.5 {
        julianDays.append(wholePart + 0.5)
        julianDays.append(wholePart + 0.75)
        julianDays.append(wholePart + 1.0)
        julianDays.append(wholePart + 1.25)
      } else {
        julianDays.append((wholePart - 1) + 0.5)
        julianDays.append((wholePart - 1) + 0.75)
        julianDays.append(wholePart + 0.0)
        julianDays.append(wholePart + 0.25)
      }
      return julianDays
    }

    internal static func moonPhase(phaseFraction: Double) -> MoonPhase {
      if phaseFraction < 0.2  {
        return .newMoon
      } else if phaseFraction < 0.23 {
        return .waxingCrescent
      } else if phaseFraction < 0.27 {
        return .firstQuarter
      } else if phaseFraction < 0.48 {
        return .waxingGibbous
      } else if phaseFraction < 0.52 {
        return .fullMoon
      } else if phaseFraction < 0.73 {
        return .waningGibbous
      } else if phaseFraction < 0.77 {
        return .lastQuarter
      } else if phaseFraction < 0.98 {
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

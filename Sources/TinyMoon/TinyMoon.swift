import Foundation

public enum TinyMoon {
  public static func calculateMoonPhase(_ date: Date = Date()) -> Moon {
    Moon(date: date)
  }

  public struct Moon: Hashable {
    init(date: Date) {
      self.date = date
      self.lunarDay = Moon.lunarDay(for: date)
      self.maxLunarDay = Moon.maxLunarDayInCycle(starting: date)
      self.moonPhase = Moon.moonPhase(lunarDay: Int(floor(lunarDay)))
      self.name = moonPhase.rawValue
      self.emoji = moonPhase.emoji
    }

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
        dateDifference = julianDay(date) - julianDay(knownNewMoonDate)
      } else {
        // Days between a known new moon date (January 6th, 2000) and the given day
        dateDifference = lessPreciseJulianDay(year: year, month: month, day: day) - lessPreciseJulianDay(year: 2000, month: 1, day: 6)
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

    /// The Julian Day Count is a uniform count of days from a remote epoch in the past and is used for calculating the days between two events.
    /// The Julian day is calculated by combining the contributions from the years, months, and day, taking into account constant offsets and rounding down the result.
    /// https://quasar.as.utexas.edu/BillInfo/JulianDatesG.html
    /// - Note: This version does not use hours or minutes to compute the Julian Day, so it will only return up to one decimal point of accuracy.
    internal static func lessPreciseJulianDay(year: Int, month: Int, day: Int) -> Double {
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

    /// Calculates the Julian Day (JD) for a given Date
    ///
    /// - Parameters:
    ///   - date: Any Swift Date to calculate the Julian Day for
    ///
    /// - Returns: The Julian Day number, rounded down to four decimal points
    ///
    /// The Julian Day Count is a uniform count of days from a remote epoch in the past and is used for calculating the days between two events.
    ///
    /// The Julian day is calculated by combining the contributions from the years, months, and day, taking into account constant offsets and rounding down the result.
    /// https://quasar.as.utexas.edu/BillInfo/JulianDatesG.html
    /// - Note: Uses hour, minute, and seconds to calculate a precise Julian Day
    internal static func julianDay(_ date: Date) -> Double {
      var calendar = Calendar.current
      calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? calendar.timeZone
      let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

      guard 
        let year = components.year,
        let month = components.month,
        let day = components.day,
        let hour = components.hour,
        let minute = components.minute,
        let second = components.second
      else {
        fatalError("Could not extract date components")
      }

      /// Used to adjust January and February to be part of the previous year.
      /// `14` is used to adjust the start of the year to March. Will either be `0` or `1`.
      let a = (14 - month) / 12
      /// The Julian Day calculation sets year 0 as 4713 BC. 
      /// To avoid working with negative numbers, `4800` is used as an offset.
      let y = year + 4800 - a
      /// Adjusts the month for the Julian Day calculation, where March is considered the first month of the year.
      let m = month + 12 * a - 3

      /// Calculate Julian Day Number for the date
      /// - `153`: A magic number used for month length adjustments.
      /// - `365`, `4`, `100`, and `400`: These relate to the number of days in a year and the correction for leap years in the Julian and Gregorian calendars.
      /// `32045` is the correction factor to align the result with the Julian Day Number.
      let jdn = Double(day) + Double((153 * m + 2) / 5) + Double(y) * 365 + Double(y / 4) - Double(y / 100) + Double(y / 400) - 32045

      /// Calculate the fraction of the day past since midnight
      ///  `1440` is the number of minutes in a day, and `86400` is the number of seconds in a day
      let dayFraction = (Double(hour) - 12) / 24 + Double(minute) / 1440 + Double(second) / 86400
      let julianDayWithTime = jdn + dayFraction
      let roundedJulianDay = (julianDayWithTime * 10000).rounded() / 10000

      return roundedJulianDay
    }

    /// Get the position of the Moon on a given Julian Day
    ///
    /// Formula from https://aa.quae.nl/en/reken/hemelpositie.html#4
    ///
    /// - Returns: Latitude (in degrees), longitude (in degrees), and distance (in kilometers)
    internal static func moonPosition(julianDay: Double) -> (Double, Double, Double) {
      let radians = Double.pi / 180
      let daysSinceJ2000 = daysSinceJ2000(from: julianDay)
      let L = (218.316 + 13.176396 * daysSinceJ2000).truncatingRemainder(dividingBy: 360) // Geocentric ecliptic longitude, in degrees
      let M = (134.963 + 13.064993 * daysSinceJ2000).truncatingRemainder(dividingBy: 360) // Mean anomaly, in degrees
      let F = (93.272 + 13.229350 * daysSinceJ2000).truncatingRemainder(dividingBy: 360) // Mean distance of the Moon from its ascending node, in degrees

      let latitude = L + 6.289 * sin(radians * M)                   // Geocentric ecliptic latitude, in degrees
      let longitude = 5.128 * sin(radians * F)                      // Geocentric ecliptic longitude, in degrees
      let distance = (385001 - 20905 * cos(radians * M)).rounded()  // Distance to the Moon, in kilometers

      return (latitude, longitude, distance)
    }

    /// The number of days since 1 January 2000, 12:00 UTC
    ///
    /// `2451545.0` is the Julian date on 1 January 2000, 12:00 UTC, aka J2000.0
    internal static func daysSinceJ2000(from jd: Double) -> Double {
      jd - 2451545.0
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
}

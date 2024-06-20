// Created by manny_lopez on 6/7/24.

import Foundation

// MARK: - TinyMoon + MoonPhase

extension TinyMoon {
  public enum MoonPhase: String {
    case newMoon = "New Moon"
    case waxingCrescent = "Waxing Crescent"
    case firstQuarter = "First Quarter"
    case waxingGibbous = "Waxing Gibbous"
    case fullMoon = "Full Moon"
    case waningGibbous = "Waning Gibbous"
    case lastQuarter = "Last Quarter"
    case waningCrescent = "Waning Crescent"

    // MARK: Internal

    static let moonPhaseFractions: [MoonPhase: Double] = [
      .newMoon: 0.0,
      .firstQuarter: 0.25,
      .fullMoon: 0.5,
      .lastQuarter: 0.75,
    ]

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

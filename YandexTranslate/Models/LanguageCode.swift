
import Foundation

enum LanguageCode: String,CaseIterable {
  case ru
  case en
  case de
}

extension LanguageCode {
  func getNameFor() -> String {
    switch self {
    case .ru:
      return "Русский"
    case .en:
      return "Aнглийский"
    case .de:
      return "Немецкий"
    }
  }
}

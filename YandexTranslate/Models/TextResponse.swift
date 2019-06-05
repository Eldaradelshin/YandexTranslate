import Foundation

struct TextResponse: Codable {
  var code: Int
  var lang: String
  var text: [String]
}

import Foundation

enum HeaderField {

  case contentType
  case authorization(tokenType: TokenType)

  var rawValue: (key: String, value: String) {
    switch self {
    case .contentType:
      return ("Content-Type", "application/json")
    case .authorization(let tokenType):
      return ("Authorization", ApiTokenProvider.shared.token(for: tokenType))
    }
  }

}

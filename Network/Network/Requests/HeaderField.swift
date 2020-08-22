import Foundation

enum HeaderField {

  //----------------------------------------------------------------------------
  // MARK: - Cases
  //----------------------------------------------------------------------------

  case contentType
  case authorization(tokenType: TokenType)

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var rawValue: (key: String, value: String) {
    switch self {
    case .contentType:
      return ("Content-Type", "application/json")
    case .authorization(let tokenType):
      return ("Authorization", ApiTokenProvider.shared.token(for: tokenType))
    }
  }

}

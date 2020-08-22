import Foundation

enum TokenType {

  //----------------------------------------------------------------------------
  // MARK: - Cases
  //----------------------------------------------------------------------------

  case user
  case admin
  case none
  case custom(token: String)

  //----------------------------------------------------------------------------
  // MARK: - Security
  //----------------------------------------------------------------------------

  var isSecureType: Bool {
    switch self {
      case .none: return false
      default: return true
    }
  }

}

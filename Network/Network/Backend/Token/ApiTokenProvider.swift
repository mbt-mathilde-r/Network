import Foundation

// References:
// https://symfonycasts.com/screencast/rest-ep2/authentication-via-token
// https://swagger.io/docs/specification/authentication/bearer-authentication/
// https://www.thefuturetrends.com/http-get-request-using-auth-header-token-in-swift3/
//let token = ""
//urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")


/*******************************************************************************
 * ApiTokenProvider
 *
 * Provider for several token.
 * /!\ Not used in this project.
 *
 ******************************************************************************/

final class ApiTokenProvider {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Token Texts ********************/

  private(set) var adminToken = ""

  private(set) var userToken = ""

  var noneToken: String {
    return ""
  }

  /******************** UserDefaults ********************/

  private let key = "ApiAuthentificationToken"
  private let userDefaults: UserDefaults

//  var token: String? {
//    return userDefaults.value(forKey: key) as? String
//  }

  static var shared = ApiTokenProvider()

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(userDefaults: UserDefaults = UserDefaults.standard) {
    self.userDefaults = userDefaults
  }

  //----------------------------------------------------------------------------
  // MARK: - UserDefaults update
  //----------------------------------------------------------------------------

  func setToken(token: String) {
    fatalError("To be implemented. Use a database pattern.")
    //userDefaults.setValue(token, forKey: key)
  }

  func deleteToken() {
    fatalError("To be implemented. Use a database pattern.")
    //userDefaults.removeObject(forKey: key)
  }

  //----------------------------------------------------------------------------
  // MARK: - Token
  //----------------------------------------------------------------------------

  func setToken(_ token: String, for type: TokenType) {
    switch type {
      case .admin: adminToken = token
      case .user: userToken = token
      case .none, .custom(_): return
    }
  }

  func token(for type: TokenType) -> String {
    var token = "Bearer" + " "
    switch type {
      case .none: token += noneToken
      case .admin: token += adminToken
      case .user: token += userToken
      case .custom(let tokenValue): token += tokenValue
    }

    return token
  }

}

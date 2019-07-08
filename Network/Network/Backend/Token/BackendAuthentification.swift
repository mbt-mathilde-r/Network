import Foundation

final class BackendAuthentification {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  private let key = "BackendAuthentificationToken"
  private let userDefaults: UserDefaults

  var token: String? {
    return userDefaults.value(forKey: key) as? String
  }

  static var shared: BackendAuthentification!

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  public init(userDefaults: UserDefaults? = nil) {
    self.userDefaults = userDefaults ?? UserDefaults.standard
  }

  //----------------------------------------------------------------------------
  // MARK: - UserDefaults update
  //----------------------------------------------------------------------------

  public func setToken(token: String) {
    userDefaults.setValue(token, forKey: key)
  }

  public func deleteToken() {
    userDefaults.removeObject(forKey: key)
  }

}

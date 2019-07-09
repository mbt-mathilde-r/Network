import Foundation

// https://jsonplaceholder.typicode.com

final class ApiServerConfiguration {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Singleton ********************/

  static var shared = ApiServerConfiguration()

  /******************** URL ********************/

  private var host: String {
    return "api.devz.mybraintech.com"
  }

  var version: String {
    #if DEBUG
    return "/melomind_dev"
    #elseif RELEASE
    return "/melomind_dev"
    #endif
  }

  var baseURL: URLComponents {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = host
    return urlComponents
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  private init() {}

}

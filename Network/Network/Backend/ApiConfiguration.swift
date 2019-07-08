import Foundation

// https://jsonplaceholder.typicode.com

final class ApiConfiguration {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Singleton ********************/

  static var shared = ApiConfiguration()

  /******************** URL ********************/

  private var host: String {
    return "api.devz.mybraintech.com"
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

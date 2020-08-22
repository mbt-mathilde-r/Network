import Foundation


/*******************************************************************************
 * ApiServerConfiguration
 *
 * Configure the api server by creating the base url.
 *
 ******************************************************************************/

final class ApiServerConfiguration {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Singleton ********************/

  static var shared = ApiServerConfiguration()

  /******************** URL ********************/

  private var host: String {
    return "jsonplaceholder.typicode.com"
  }

  /// Return server version (Debug, release, ...).
  var version: String {
    #if DEBUG
    return ""
    #elseif RELEASE
    return ""
    #endif
  }

  /// The base url for the server.
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

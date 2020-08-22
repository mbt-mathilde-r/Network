import Foundation

/*******************************************************************************
 * HTTPMethod
 *
 * Rest http methods.
 * https://developer.mozilla.org/fr/docs/Web/HTTP/Methode
 *
 ******************************************************************************/

enum HTTPMethod: String {

  //----------------------------------------------------------------------------
  // MARK: - Cases
  //----------------------------------------------------------------------------

  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"

}

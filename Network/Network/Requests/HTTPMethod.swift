import Foundation

/// Rest http methods.
/// https://developer.mozilla.org/fr/docs/Web/HTTP/Methode
/// - get:
/// - post:
/// - put:
/// - delete:
enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
}

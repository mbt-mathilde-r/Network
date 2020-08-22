import Foundation

/*******************************************************************************
 * QueryBuilder
 *
 * Build a query from differents parameters.
 *
 * https://cocoacasts.com/working-with-nsurlcomponents-in-swift
 *
 ******************************************************************************/

final class QueryBuilder {

  /// Build a query from given parameters.
  /// - Parameter parameters: Parameters to use for the query.
  /// - Returns: A string representation of the built query.
  static func build(from parameters: [String: Any]?) -> String? {
    guard let parameters = parameters else { return nil }

    var urlQueryItems = [URLQueryItem]()
    for parameter in parameters {
      let key = parameter.key
      let value = String(describing:parameter.value)
      let urlQueryItem = URLQueryItem(name: key, value: value)
      urlQueryItems.append(urlQueryItem)
    }

    var urlComponents = URLComponents()
    urlComponents.queryItems = urlQueryItems

    return urlComponents.percentEncodedQuery
  }

}

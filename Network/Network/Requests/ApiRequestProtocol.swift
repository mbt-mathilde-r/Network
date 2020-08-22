import Foundation

/*******************************************************************************
 * ApiRequestProtocol
 *
 * A type that represent an API request.
 *
 ******************************************************************************/

protocol ApiRequestProtocol {

  /// The request endpoint
  var endpoint: String { get }

  /// HTTPMethod as get, post, patch, ...
  var method: HTTPMethod { get }

  /// The type of query as url, body, ...
  var queryType: QueryType { get }

  /// Query (percentEncodedQuery) related to the request. 
  var query: String? { get }

  /// If any, th token associated to the request.
  var tokenType: TokenType { get }

  var headers: [String: String]? { get }

  var httpBody: Data? { get }

  var parameters: [String: Any]? { get }
}

//==============================================================================
// MARK: - Default implementations
//==============================================================================

extension ApiRequestProtocol {

  var headers: [String: String]? {
    var headers = [String: String]()

    let contentType = HeaderField.contentType.rawValue
    headers[contentType.key] = contentType.value

    let authorization = HeaderField.authorization(tokenType: tokenType).rawValue
    if tokenType.isSecureType {
      headers[authorization.key] = authorization.value
    }

    return headers
  }

  var query: String? {
    return QueryBuilder.build(from: parameters)
  }

  // TODO: To remove maybe?
  var httpBody: Data? {
    if method == .get { return nil }
    guard let parameters = parameters else { return nil }
    return try? JSONSerialization.data(withJSONObject: parameters, options: [])
  }

  var queryType: QueryType {
    switch method {
      case .get: return .url
      case .delete, .patch, .post, .put: return .body
    }
  }
  
}

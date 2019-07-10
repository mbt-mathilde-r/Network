import Foundation

protocol ApiRequestProtocol {
  
  var endpoint: String { get }

  var method: HTTPMethod { get } // get, post, patch

  var queryType: QueryType { get }

  var query: String? { get } // PercentEncodedQuery

  var tokenType: TokenType { get }

  var headers: [String: String]? { get }

  // Used for POST, PATCH AND PUT
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
    if tokenType != .none {
      headers[authorization.key] = authorization.value
    }

    return headers
  }

  var query: String? {
    return QueryBuilder.build(from: parameters)
  }

  // TO REMOVE
  var httpBody: Data? {
    if method == .get { return nil }
    guard let parameters = parameters else { return nil }
    return try? JSONSerialization.data(withJSONObject: parameters, options: [])
  }

  var queryType: QueryType {
    switch method {
    case .get:
      return .url
    case .delete, .patch, .post, .put:
      return .body
    }
  }
  
}

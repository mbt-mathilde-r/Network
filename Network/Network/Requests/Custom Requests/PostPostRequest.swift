import Foundation

final class PostPostRequest: RequestProtocol {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  private(set) var model: PostModel?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(userId: Int, title: String, body: String) {
    model = PostModel(userId: userId, title: title, body: body)
  }

  //----------------------------------------------------------------------------
  // MARK: - BackendAPIRequest
  //----------------------------------------------------------------------------

  // === urlComponents.path
  var endpoint: String {
    return "/posts"
  }

  var method: HTTPMethod {
    return .post
  }

  var queryType: QueryType {
    return .body
  }

  var httpBody: Data? {
    if method == .get { return nil }
    guard let parameters = model.dictionary else { return nil }
    return try? JSONSerialization.data(withJSONObject: parameters, options: [])
  }

  /// For query
  var parameters: [String: Any]? {
    return model.dictionary
  }

  var tokenType: TokenType {
    return .none
  }

}

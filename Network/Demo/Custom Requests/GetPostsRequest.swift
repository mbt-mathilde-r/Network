import Foundation

final class GetPostsRequest: RequestProtocol {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  private(set) var model: [PostModel]?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // MARK: - BackendAPIRequest
  //----------------------------------------------------------------------------

  var endpoint: String {
    return "/posts"
  }

  var method: HTTPMethod {
    return .get
  }

  var queryType: QueryType {
    return .url
  }

  var parameters: [String: Any]? {
    return nil
  }

  var tokenType: TokenType {
    return .none
  }

}

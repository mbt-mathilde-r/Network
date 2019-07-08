import Foundation

// TODO: Rename with "<modelName><HttpMethod>Request"
final class GetPostRequest: RequestProtocol {


  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  private(set) var model: PostModel?

  private let postId: Int?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(postId: Int?) {
    self.postId = postId
  }

  //----------------------------------------------------------------------------
  // MARK: - BackendAPIRequest
  //----------------------------------------------------------------------------
  
  var endpoint: String {
    var path = "/posts"

    if let postId = postId {
      path += "/\(postId)"
    }

    return path
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

}

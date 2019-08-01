import Foundation

final class PostPostOperation:
NetworkOperation<PostModel, PostModel, PostPostRequest> {

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override init(request: PostPostRequest, dependencies: [Operation]? = nil) {
    super.init(request: request, dependencies: dependencies)
  }

  init(userId: Int,
       title: String,
       body: String,
       dependencies: [Operation]? = nil) {
    let request = PostPostRequest(userId: userId, title: title, body: body)
    super.init(request: request, dependencies: dependencies)
  }

}

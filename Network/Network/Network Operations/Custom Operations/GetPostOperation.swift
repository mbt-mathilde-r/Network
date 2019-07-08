import Foundation

final class GetPostOperation: NetworkOperation<PostModel, GetPostRequest> {

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(postId: Int, dependencies: [Operation]? = nil) {
    let request = GetPostRequest(postId: postId)
    super.init(request: request, dependencies: dependencies)
  }
}

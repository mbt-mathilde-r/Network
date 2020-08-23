import Foundation

final class GetPostsOperation:
NetworkOperation<[PostModel], [PostModel], GetPostsRequest> {

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(dependencies: [Operation]? = nil) {
    let request = GetPostsRequest()
    super.init(request: request, dependencies: dependencies)
  }

}

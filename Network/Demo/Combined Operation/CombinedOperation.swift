import Foundation

final class CombinedOperation: AsynchronousBlockOperation {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var getOperation: GetPostOperation
  var postOperation: PostPostOperation

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override init() {
    getOperation = GetPostOperation(postId: 13)
    postOperation = PostPostOperation(userId: 42,
                                      title: "Title",
                                      body: "body",
                                      dependencies: [getOperation])
    super.init()

    getOperation.success = { model in print("Get completed") }

    postOperation.success = { [weak self] model in
      print("Post completed")
      self?.finish()
    }
  }

  override func start() {
    super.start()

    NetworkQueue.shared.addOperation(operation: getOperation)
    NetworkQueue.shared.addOperation(operation: postOperation)

    getOperation.start()
    postOperation.start()
  }

}

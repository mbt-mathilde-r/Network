import Foundation

/*******************************************************************************
 * CombinedOperation
 *
 * Example to demonstrate how to combine multiple operations.
 *
 ******************************************************************************/

final class CombinedOperation: AsynchronousBlockOperation {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Operations ********************/

  var getOperation: GetPostOperation
  var postOperation: PostPostOperation

  /******************** Result ********************/

  /// Dumb data to demonstrate how to transfert result between operations.
  var userId: Int?

  /******************** Callbacks ********************/

  /// Closure called when a operation succefully finished.
  /// Called in background thread.
  var didSucceed: ((Int) -> Void)?

  /// Closure called when a operation unsuccefully finished.
  /// Called in background thread.
  var didFail: ((Error) -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override init() {
    getOperation = GetPostOperation(postId: 5)
    postOperation = PostPostOperation(userId: 5,
                                      title: "Title",
                                      body: "body",
                                      dependencies: [getOperation])
    super.init()
    setup()
  }

  private func setup() {
    setupGetOperation()
    setupPostOperation()
  }

  private func setupGetOperation() {
    getOperation.completionBlock = { [weak self] in
      guard let result = self?.getOperation.result else { return }
      switch result {
        case .success(let post): self?.userId = post.userId
        case .failure(let error):
          self?.didFail?(error)
          self?.finish()
      }
    }

  }

  private func setupPostOperation() {
    postOperation.completionBlock = { [weak self] in
      defer { self?.finish() }
      guard let result = self?.postOperation.result else { return }
      switch result {
        case .success(_):
          guard let userId = self?.userId else {
            let error = NSError(domain: "Combined", code: 1)
            self?.didFail?(error)
            return
          }
          self?.didSucceed?(userId)

        case .failure(let error):
          self?.didFail?(error)
      }
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Operation lifecycle
  //----------------------------------------------------------------------------

  override func main() {
    getOperation.start()
    postOperation.start()
  }

  override func cancel() {
    getOperation.cancel()
    postOperation.cancel()
    super.cancel()
  }

  override func finish() {
    getOperation.cancel()
    postOperation.cancel()
    super.finish()
  }


}

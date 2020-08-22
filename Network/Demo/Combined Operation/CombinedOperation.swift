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
    getOperation = GetPostOperation(postId: 13)
    postOperation = PostPostOperation(userId: 42,
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
    getOperation.didSucceed =
      { [weak self] model in self?.userId = model.userId }

    getOperation.didFail = { [weak self] error in
      self?.finish()
      self?.didFail?(error)
    }
  }

  private func setupPostOperation() {
    postOperation.didSucceed = { [weak self] model in
      self?.finish()

      guard let userId = self?.userId else {
        let error = NSError(domain: "Combined", code: 1)
        self?.didFail?(error)
        return
      }

      self?.didSucceed?(userId)
    }

    postOperation.didFail = { [weak self] error in
      self?.finish()
      self?.didFail?(error)
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

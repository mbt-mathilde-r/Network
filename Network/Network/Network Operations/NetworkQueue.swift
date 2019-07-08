import Foundation

class NetworkQueue {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Queue ********************/

  let queue = OperationQueue()

  /******************** Singleton ********************/

  public static var shared = NetworkQueue()

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  public init() {
    setup()
  }

  private func setup() {
    queue.maxConcurrentOperationCount = 1
  }

  //----------------------------------------------------------------------------
  // MARK: - Queue adding
  //----------------------------------------------------------------------------

  func addOperation(operation: Operation) {
    queue.addOperation(operation)
  }

  func addOperations(operations: [Operation], waitUntilFinished: Bool = false) {
    queue.addOperations(operations, waitUntilFinished: waitUntilFinished)
  }

  //----------------------------------------------------------------------------
  // MARK: - Queue life cycle
  //----------------------------------------------------------------------------

  func waitUntilAllOperationsAreFinished() {
    queue.waitUntilAllOperationsAreFinished()
  }

  func cancelAllOperations() {
    queue.cancelAllOperations()
  }

}

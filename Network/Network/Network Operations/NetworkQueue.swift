import Foundation


/*******************************************************************************
 * NetworkQueue
 *
 * A queue that regulates the execution of network operations.
 * TODO: Force only network operation to be added?
 *
 ******************************************************************************/

final class NetworkQueue {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Queue ********************/


  /// A queue that regulates the execution of operations.
  private let queue = OperationQueue()

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

  /// Adds the specified operation.
  /// - Parameter operation: The operation to be added to the queue.
  func addOperation(operation: Operation) {
    queue.addOperation(operation)
  }

  /// Adds the specified operations to the queue.
  /// - Parameters:
  ///   - operations: The operations to be added to the queue.
  ///   - waitUntilFinished: If true, the current thread is blocked until all
  ///   of the specified operations finish executing. If false, the operations
  ///   are added to the queue and control returns immediately to the caller.
  func addOperations(operations: [Operation], waitUntilFinished: Bool = false) {
    queue.addOperations(operations, waitUntilFinished: waitUntilFinished)
  }

  //----------------------------------------------------------------------------
  // MARK: - Queue life cycle
  //----------------------------------------------------------------------------

  /// Blocks the current thread until all of the receiver’s queued and executing
  /// operations finish executing.
  func waitUntilAllOperationsAreFinished() {
    queue.waitUntilAllOperationsAreFinished()
  }

  /// Cancels all queued and executing operations.
  func cancelAllOperations() {
    queue.cancelAllOperations()
  }

}

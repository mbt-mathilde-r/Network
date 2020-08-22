import Foundation

/*******************************************************************************
 * OperationState
 *
 * A state representation of an operation.
 *
 ******************************************************************************/

fileprivate enum OperationState: String {
  case ready = "isReady"
  case executing = "isExecuting"
  case finished = "isFinished"
  case cancelled = "isCancelled"
}

/*******************************************************************************
 * AsynchronousBlockOperation
 *
 * Base class for concurrent operation.
 *
 * More information are available at the official Apple documentation:
 * https://developer.apple.com/library/archive/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationObjects/OperationObjects.html#//apple_ref/doc/uid/TP40008091-CH101-SW16
 *
 ******************************************************************************/

class AsynchronousBlockOperation: BlockOperation {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** State ********************/

  override var isAsynchronous: Bool {
    return true
  }

  override var isExecuting: Bool {
    return state == .executing
  }

  override var isFinished: Bool {
    return state == .finished
  }

  private var state = OperationState.ready {
    willSet { willChangeValue(forKey: newValue.rawValue) }
    didSet { didChangeValue(forKey: state.rawValue) }
  }

  //----------------------------------------------------------------------------
  // MARK: - Operation life cycle
  //----------------------------------------------------------------------------

  override func start() {
    // Apple documentation note
    // https://developer.apple.com/documentation/foundation/operation/1416837-start
    // If you are implementing a concurrent operation, you must override this
    // method and use it to initiate your operation. Your custom implementation
    // must not call super at any time.
    
    guard isCancelled == false else { return }
    state = .executing
    main()
  }

  func finish() {
    state = .finished
  }

}

import Foundation


/*******************************************************************************
 * Batcher
 *
 * Simple wrapper class to demonstrate how to batch operations
 *
 ******************************************************************************/

final class Batcher {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var batchOperationCount = 5

  var currentBatchOperationIndex = 0

  //----------------------------------------------------------------------------
  // MARK: - Batch
  //----------------------------------------------------------------------------

  func addData(title: String, completion: (() -> Void)? = nil) {
    currentBatchOperationIndex += 1
    let body = "Body"
    let newOperation = PostPostOperation(userId: currentBatchOperationIndex,
                                         title: title,
                                         body: body)

    newOperation.didSucceed = { model in
      print("Batch \(model.title) with index: \(model.userId)")
      completion?()
    }

    NetworkQueue.shared.addOperation(newOperation)
  }
}

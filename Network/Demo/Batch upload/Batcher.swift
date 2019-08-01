import Foundation

final class Batcher {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var batchOperationCount = 5

  var currentBatchOperationIndex = 0

  //----------------------------------------------------------------------------
  // MARK: - Batch
  //----------------------------------------------------------------------------

  func addData(title: String) {
    currentBatchOperationIndex += 1
    let body = "Body"
    let newOperation = PostPostOperation(userId: currentBatchOperationIndex,
                                         title: title,
                                         body: body)

    newOperation.success = { model in
      print("Batch \(model.title) with index: \(model.userId)")
    }

    NetworkQueue.shared.addOperation(operation: newOperation)
  }
}

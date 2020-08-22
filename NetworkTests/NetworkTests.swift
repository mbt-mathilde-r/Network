//
//  NetworkTests.swift
//  NetworkTests
//
//  Created by Laurent Noudohounsi on 25/06/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import XCTest
@testable import Network

class NetworkTests: XCTestCase {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Test expectation ********************/

  let timeout: TimeInterval = 10


  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  var queue = OperationQueue()

  override func setUp() {
    queue = OperationQueue()
    queue.maxConcurrentOperationCount = 1
  }

  override func tearDown() {
    NetworkQueue.shared.cancelAllOperations()
  }


  //----------------------------------------------------------------------------
  // MARK: - Waiter
  //----------------------------------------------------------------------------

  private func displayWaiterResult(result: XCTWaiter.Result) {
    switch result {
      case .completed: print("Everything is fullfiled.")
      case .incorrectOrder: print("Unexpected order.")
      case .interrupted: print("Waiter has been interrupted.")
      case .invertedFulfillment: print("Inverted expectaction is fullfiled.")
      case .timedOut: print("Everything did not fullfill.")
      default: print("Not handled case.")
    }
  }

  private func wait(for expectations: [XCTestExpectation]) -> XCTWaiter.Result {
    let waiterResult =
      XCTWaiter.wait(for: expectations, timeout: timeout, enforceOrder: true)
    displayWaiterResult(result: waiterResult)
    return waiterResult
  }

  private func wait(for expectation: XCTestExpectation) -> XCTWaiter.Result {
    return wait(for: [expectation])
  }

  //----------------------------------------------------------------------------
  // MARK: - Simple
  //----------------------------------------------------------------------------

  func testIntegrationSimpleOperation() {
    let getExpectation =
      XCTestExpectation(description: "getPostOperation expectation")

    let getPostOperation = GetPostOperation(postId: 13)

    getPostOperation.completionBlock = {
      switch getPostOperation.result {
        case .success(_): getExpectation.fulfill()
        case .failure(_): return
      }
    }

//    getPostOperation.didSucceed = { model in
//      print("Get Succed: \(model.userId)")
//      getExpectation.fulfill()
//    }

//    getPostOperation.didFail = { error in XCTFail(error.localizedDescription) }

    queue.addOperation(getPostOperation)
    let expectationsResult = wait(for: getExpectation)
    XCTAssert(expectationsResult == .completed, "Error with expectations")
  }

  func testIntegrationMultipleOperation() {
    var expectations = [XCTestExpectation]()

    let getExpectation =
      XCTestExpectation(description: "getPostOperation expectation")

    let getPostOperation = GetPostOperation(postId: 13)
    getPostOperation.completionBlock = {
      switch getPostOperation.result {
        case .success(_): getExpectation.fulfill()
        case .failure(_): return
      }
    }

//    getPostOperation.didSucceed = { model in
//      print("Get Succed: \(model.userId)")
//      getExpectation.fulfill()
//    }

//    getPostOperation.didFail = { error in XCTFail(error.localizedDescription) }
    expectations.append(getExpectation)



    let postExpectation =
      XCTestExpectation(description: "postPostOperation expectation")
    let postPostOperation = PostPostOperation(userId: 42,
                                              title: "title",
                                              body: "body")

    postPostOperation.completionBlock = {
      switch postPostOperation.result {
        case .success(_): postExpectation.fulfill()
        case .failure(_): return
      }
    }

//    postPostOperation.didSucceed = { model in
//      print("Post Succed: \(model.userId)")
//      postExpectation.fulfill()
//    }

//    postPostOperation.didFail = { error in XCTFail(error.localizedDescription) }
    expectations.append(postExpectation)

    queue.addOperations([getPostOperation, postPostOperation], waitUntilFinished: true)

    let expectationsResult = wait(for: expectations)
    XCTAssert(expectationsResult == .completed, "Error with expectations")
  }

  func testIntegrationDependency() {
    var expectations = [XCTestExpectation]()

    let getExpectation =
      XCTestExpectation(description: "getPostDepOperation expectation")

    let getPostOperation = GetPostOperation(postId: 13)
    getPostOperation.completionBlock = {
      switch getPostOperation.result {
        case .success(_): getExpectation.fulfill()
        case .failure(_): return
      }
    }
//    getPostOperation.didSucceed = { model in
//      print("Get Succed: \(model.userId)")
//      getExpectation.fulfill()
//    }
////    getPostOperation.didFail =
////      { error in XCTFail(error.localizedDescription) }

    expectations.append(getExpectation)

    let postDepExpectation =
      XCTestExpectation(description: "postPostOperation expectation")

    let postPostDepOperation =
      PostPostOperation(userId: 13,
                        title: "title",
                        body: "body",
                        dependencies: [getPostOperation])
    postPostDepOperation.completionBlock = {
      switch postPostDepOperation.result {
        case .success(_): postDepExpectation.fulfill()
        case .failure(_): return
      }
    }

//    postPostDepOperation.didSucceed = { model in
//      print("Post 2 Succed: \(model.userId)")
//      postDepExpectation.fulfill()
//    }

//    postPostDepOperation.didFail =
//      { error in XCTFail(error.localizedDescription) }

    expectations.append(postDepExpectation)


    queue.addOperation(postPostDepOperation)
    queue.addOperation(getPostOperation)

    let expectationsResult = wait(for: expectations)
    XCTAssert(expectationsResult == .completed, "Error with expectations")
  }

  func testIntegrationCancellation() {
    var expectations = [XCTestExpectation]()

    let getExpectation =
      XCTestExpectation(description: "getPostOperation expectation")
    let getPostOperation = GetPostOperation(postId: 13)
    getPostOperation.completionBlock = {
      switch getPostOperation.result {
        case .success(_): return
        case .failure(_): getExpectation.fulfill()
      }
    }
////    getPostOperation.didSucceed = { _ in XCTFail("Should not complete.") }
//    getPostOperation.didFail = { error in getExpectation.fulfill() }
    expectations.append(getExpectation)


    let postExpectation =
      XCTestExpectation(description: "postPostOperation expectation")
    let postPostOperation =
      PostPostOperation(userId: 42, title: "title", body: "body")
    postPostOperation.completionBlock = {
      switch postPostOperation.result {
        case .success(_): return
        case .failure(_): postExpectation.fulfill()
      }
    }
//    postPostOperation.didSucceed = {  _ in XCTFail("Should not complete.") }
//    postPostOperation.didFail = { error in postExpectation.fulfill() }
    expectations.append(postExpectation)

    queue.addOperation(getPostOperation)
    queue.addOperation(postPostOperation)
    queue.cancelAllOperations()

    let expectationsResult = wait(for: expectations)
    XCTAssert(expectationsResult == .completed, "Error with expectations")
  }

  //----------------------------------------------------------------------------
  // MARK: - Combined
  //----------------------------------------------------------------------------

  func testIntegrationCombined() {
    let expectation =
      XCTestExpectation(description: "CombinedOperation expectation")

    let combinedOperation = CombinedOperation()
    combinedOperation.didSucceed = { result in expectation.fulfill() }

    queue.addOperation(combinedOperation)

    let expectationsResult = wait(for: expectation)
    XCTAssert(expectationsResult == .completed, "Error with expectations")
  }

  //----------------------------------------------------------------------------
  // MARK: - Batch
  //----------------------------------------------------------------------------

  func testIntegrationBatch() {
    let batcher = Batcher()

    let batchTitles = ["One", "Two", "Three"]
    var expectations = [XCTestExpectation]()

    for batchTitle in batchTitles {
      let expectation = XCTestExpectation(description: batchTitle)
      expectations.append(expectation)
    }

    XCTAssert(expectations.count == batchTitles.count, "")
    for (index, batchTitle) in batchTitles.enumerated() {
      let expectation = expectations[index]
      batcher.addData(title: batchTitle) {
        expectation.fulfill()
      }
    }

    let expectationsResult = wait(for: expectations)
    XCTAssert(expectationsResult == .completed, "Error with expectations")
  }

}

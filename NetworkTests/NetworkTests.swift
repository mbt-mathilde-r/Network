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

  let timeout: TimeInterval = 4


  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override func setUp() {
  }

  override func tearDown() {
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

    let getPostOperation = GetPostOperation(postId: 1)

    getPostOperation.completionBlock = {
      switch getPostOperation.result {
        case .success(_): getExpectation.fulfill()
        case .failure(_): return
      }
    }

    NetworkQueue.shared.addOperation(getPostOperation)
    let expectationsResult = wait(for: getExpectation)
    XCTAssert(expectationsResult == .completed, "Error with expectations")
  }

  func testIntegrationMultipleOperation() {
    var expectations = [XCTestExpectation]()

    let getExpectation =
      XCTestExpectation(description: "getPostOperation expectation")

    let getPostOperation = GetPostOperation(postId: 2)
    getPostOperation.completionBlock = {
      switch getPostOperation.result {
        case .success(_): getExpectation.fulfill()
        case .failure(_): return
      }
    }

    expectations.append(getExpectation)



    let postExpectation =
      XCTestExpectation(description: "postPostOperation expectation")

    let postPostOperation =
      PostPostOperation(userId: 2, title: "title", body: "body")
    postPostOperation.completionBlock = {
      switch postPostOperation.result {
        case .success(_): postExpectation.fulfill()
        case .failure(_): return
      }
    }

    expectations.append(postExpectation)

    NetworkQueue.shared.addOperation(getPostOperation)
    NetworkQueue.shared.addOperation(postPostOperation)

    let expectationsResult = wait(for: expectations)
    XCTAssert(expectationsResult == .completed, "Error with expectations")
  }

  func testIntegrationDependency() {
    var expectations = [XCTestExpectation]()

    let getExpectation =
      XCTestExpectation(description: "getPostDepOperation expectation")

    let getPostOperation = GetPostOperation(postId: 3)
    getPostOperation.completionBlock = {
      switch getPostOperation.result {
        case .success(_): getExpectation.fulfill()
        case .failure(_): return
      }
    }

    expectations.append(getExpectation)

    let postDepExpectation =
      XCTestExpectation(description: "postPostOperation expectation")

    let postPostDepOperation =
      PostPostOperation(userId: 3,
                        title: "title",
                        body: "body",
                        dependencies: [getPostOperation])
    postPostDepOperation.completionBlock = {
      switch postPostDepOperation.result {
        case .success(_): postDepExpectation.fulfill()
        case .failure(_): return
      }
    }

    expectations.append(postDepExpectation)

    NetworkQueue.shared.addOperation(getPostOperation)
    NetworkQueue.shared.addOperation(postPostDepOperation)

    let expectationsResult = wait(for: expectations)
    XCTAssert(expectationsResult == .completed, "Error with expectations")
  }

  func testIntegrationCancellation() {
    var expectations = [XCTestExpectation]()

    let getExpectation =
      XCTestExpectation(description: "getPostOperation expectation")
    let getPostOperation = GetPostOperation(postId: 4)
    getPostOperation.completionBlock = {
      switch getPostOperation.result {
        case .success(_): return
        case .failure(_): getExpectation.fulfill()
      }
    }

    expectations.append(getExpectation)


    let postExpectation =
      XCTestExpectation(description: "postPostOperation expectation")
    let postPostOperation =
      PostPostOperation(userId: 4, title: "title", body: "body")
    postPostOperation.completionBlock = {
      switch postPostOperation.result {
        case .success(_): return
        case .failure(_): postExpectation.fulfill()
      }
    }

    expectations.append(postExpectation)

    NetworkQueue.shared.addOperation(getPostOperation)
    NetworkQueue.shared.addOperation(postPostOperation)
    NetworkQueue.shared.cancelAllOperations()

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
    combinedOperation.completionBlock = { expectation.fulfill() }

    NetworkQueue.shared.addOperation(combinedOperation)

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

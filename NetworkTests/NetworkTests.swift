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

  var expectation = XCTestExpectation(description: "Api call.")
  let timeout: TimeInterval = 10

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override func setUp() {
  }

  override func tearDown() {
  }

  //----------------------------------------------------------------------------
  // MARK: - Utilities
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

  func testSimpleExpectaiton() {
    let getPostOperation = GetPostOperation(postId: 1)
    getPostOperation.success = { [weak self] _ in self?.expectation.fulfill() }
    getPostOperation.failure = { error in XCTFail(error.localizedDescription) }

    NetworkQueue.shared.addOperation(operation: getPostOperation)

    let waiterResult =
      XCTWaiter.wait(for: [expectation], timeout: timeout, enforceOrder: true)

    displayWaiterResult(result: waiterResult)
  }














  //----------------------------------------------------------------------------
  // MARK: - Simple
  //----------------------------------------------------------------------------

  func testSimple() {
    let getPostOperation = GetPostOperation(postId: 1)
    getPostOperation.success = { model in print("Success: \(model.userId)") }
    getPostOperation.failure = { error in print("\(error)") }

    NetworkQueue.shared.addOperation(operation: getPostOperation)

    while true { }
  }


















  //----------------------------------------------------------------------------
  // MARK: - Batch
  //----------------------------------------------------------------------------

  func testBatch() {
    let batcher = Batcher()

    batcher.addData(title: "One")
    sleep(2)
    batcher.addData(title: "Two")
    sleep(2)
    batcher.addData(title: "Three")

    while true { }
  }















  //----------------------------------------------------------------------------
  // MARK: - Multiple
  //----------------------------------------------------------------------------

  func testMultipleCall() {

    /******************** Get operation ********************/

    let getPostOperation = GetPostOperation(postId: 4)

    getPostOperation.success = { model in print("Get Succed: \(model.userId)") }
    getPostOperation.failure = { error in print("Get Failed: \(error)") }

    /******************** Post operation ********************/

    let postPostOperation =
      PostPostOperation(userId: 13, title: "title", body: "body")

    postPostOperation.success = { model in print("Post Succed: \(model.userId)") }
    postPostOperation.failure = { error in print("Post Failed: \(error)") }

    /******************** Settings ********************/

    let manualAdding = true
    let dependency = false
    let waitFor = false
    let latency = false

    //--------------------------------------------------------------------------
    // MARK: - Manually operation adding.
    //--------------------------------------------------------------------------


    if manualAdding {
      NetworkQueue.shared.addOperation(operation: getPostOperation)
      NetworkQueue.shared.addOperation(operation: postPostOperation)
    }























    //--------------------------------------------------------------------------
    // MARK: - Manually operation adding with dependency.
    //--------------------------------------------------------------------------

    if dependency {
      let postPostDepOperation =
        PostPostOperation(userId: 13,
                          title: "title",
                          body: "body",
                          dependencies: [getPostOperation])

      postPostDepOperation.success =
        { model in print("Post 2 Succed: \(model.userId)") }
      postPostDepOperation.failure =
        { error in print("Post 2 Failed: \(error.localizedDescription)") }

      NetworkQueue.shared.addOperation(operation: getPostOperation)
      NetworkQueue.shared.addOperation(operation: postPostDepOperation)

//      NetworkQueue.shared.addOperation(operation: postPostDepOperation)
//      NetworkQueue.shared.addOperation(operation: getPostOperation)
    }
























    //--------------------------------------------------------------------------
    // MARK: - Wait for all operations to complete.
    //--------------------------------------------------------------------------

    if waitFor {
      let operations = [getPostOperation, postPostOperation]
      NetworkQueue.shared.addOperations(operations: operations,
                                        waitUntilFinished: true)
      print("Done")
    }






















    //--------------------------------------------------------------------------
    // MARK: - Latency
    //--------------------------------------------------------------------------

    if latency {

      // Use network latency utility.

      NetworkQueue.shared.addOperation(operation: getPostOperation)
      NetworkQueue.shared.addOperation(operation: postPostOperation)

      sleep(1)
      NetworkQueue.shared.cancelAllOperations()

    }

    while true { }

  }





























  //----------------------------------------------------------------------------
  // MARK: - Combined
  //----------------------------------------------------------------------------


  func testCombined() {
    let combinedOperation = CombinedOperation()
    combinedOperation.completionBlock = { print("Combined completed") }

    NetworkQueue.shared.addOperation(operation: combinedOperation)

    while true { }
  }

















}

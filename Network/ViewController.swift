//
//  ViewController.swift
//  Network
//
//  Created by Laurent Noudohounsi on 25/06/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    getSessionsHistory(success: { history in
      print("succes: \(history)")
    }, failure: { error in
      print("error : \(error)")
    })
  }

  /// Get app config
  ///
  /// - Parameters:
  ///   - success: success closure with the config
  ///   - failure: failure closure with error message
  func getConfig(success: ((Config?) -> Void)? = nil,
                 failure: ((Error) -> Void)? = nil) {
    let operation = GetConfigOperation()

    operation.success = { result in success?(result?.data.first)}
    operation.failure = failure

    NetworkQueue.shared.addOperation(operation: operation)
  }

  /// Get list of authentified user sessions
  ///
  /// - Parameters:
  ///   - success: success closure with the config
  ///   - failure: failure closure with error message
  func getSessions(success: ((Session?) -> Void)? = nil,
                   failure: ((Error) -> Void)? = nil) {
    let operation = GetSessionsOperation()

    operation.success = { result in success?(result?.data.first)}
    operation.failure = failure

    NetworkQueue.shared.addOperation(operation: operation)
  }

  func getSessionsHistory(success: ((SessionHistory?) -> Void)? = nil,
                          failure: ((Error) -> Void)? = nil) {
    let operation = GetSessionsHistoryOperation()

    operation.success = { result in success?(result?.data.first)}
    operation.failure = failure

    NetworkQueue.shared.addOperation(operation: operation)
  }
}


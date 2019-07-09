//
//  ViewController.swift
//  Network
//
//  Created by Laurent Noudohounsi on 25/06/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


  //----------------------------------------------------------------------------
  // MARK: - View life cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()

    getSessions() { result in

      // We can use the result in (at least) 3 different ways

      // 1) with switch
      switch result {
      case .success(let history): print("succes: \(history)")
      case .failure(let error): print("error : \(error)")
      }

      // 2) with do-catch
      do {
        let history = try result.get()
        print("succes: \(history)")
      } catch {
        print("error : \(error)")
      }

      // 3) or the beloved guard
      guard let history = try? result.get() else {
        print("Oops")
        return
      }
      print("succes: \(history)")

    }
  }


  //----------------------------------------------------------------------------
  // MARK: - Api calls
  //----------------------------------------------------------------------------

  /// Get app config
  ///
  /// - Parameters:
  ///   - success: success closure with the config
  ///   - failure: failure closure with error message
  func getConfig(completion: ((Result<Config, Error>) -> Void)?) {
    let operation = GetConfigOperation()

//    operation.completionBlock = { completion?(operation.result) }

    // Or

    // Force wrapping in `result.data.first!` is temporary. The model will
    // return the good type `result.data.first` directly soon.
    // Stay tunned 🤓
    operation.success = { result in completion?(.success(result.data.first!))}
    operation.failure = { error in completion?(.failure(error)) }

    NetworkQueue.shared.addOperation(operation: operation)
  }

  /// Get list of authentified user sessions
  ///
  /// - Parameters:
  ///   - success: success closure with the config
  ///   - failure: failure closure with error message
  func getSessions(completion: ((Result<Session, Error>) -> Void)?) {
    let operation = GetSessionsOperation()

    operation.success = { result in completion?(.success(result.data.first!))}
    operation.failure = { error in completion?(.failure(error)) }

    NetworkQueue.shared.addOperation(operation: operation)
  }

  typealias SessionHistoryResult = Result<SessionHistory, Error>
  func getSessionsHistory(completion: ((SessionHistoryResult) -> Void)?) {
    let operation = GetSessionsHistoryOperation()
    operation.success = { result in completion?(.success(result.data.first!))}
    operation.failure = { error in completion?(.failure(error)) }

    NetworkQueue.shared.addOperation(operation: operation)
  }

}


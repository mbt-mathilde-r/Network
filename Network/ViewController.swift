//
//  ViewController.swift
//  Network
//
//  Created by Laurent Noudohounsi on 25/06/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  var sessions = [Int: [SessionHistory]]() {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }

  var config: Config?

  let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    return dateFormatter
  }()

  //----------------------------------------------------------------------------
  // MARK: - View life cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(UINib(nibName: "SessionTableViewCell", bundle: nil),
                       forCellReuseIdentifier: "session")

    getConfig() { result in
      switch result {
      case .success(let config):
        self.config = config
        self.getSessionsHistoryFromConfig()
      case .failure(let error):
        print("Cannot get config \(error)")
      }
    }
  }


  //----------------------------------------------------------------------------
  // MARK: - Api calls
  //----------------------------------------------------------------------------

  typealias SessionHistoryResult = Result<[SessionHistory], Error>

  private func getSessionsHistoryFromConfig() {
    guard let config = config else { return }

    self.getSessionsHistory(for: config.phases)  { result in
      switch result {
      case .success(let sessions):
        if let first = sessions.first { self.sessions[first.phase] = sessions }
      case .failure(let error): print("error : \(error)")
      }
    }

  }

  func getSessionsHistory(for phases: [ConfigPhase],
                          dependencies: [Operation]? = nil,
                          completion: ((SessionHistoryResult) -> Void)?) {
    let operations = phases.map { phase -> Operation in
      let parameters = SessionHistoryParameters(phase: phase.index)
      let operation = GetSessionsHistoryOperation(parameters: parameters)
      operation.completionBlock = { completion?(operation.result) }
      return operation
    }
    NetworkQueue.shared.addOperations(operations: operations)
  }

  /// Get app config
  ///
  /// - Parameters:
  ///   - success: success closure with the config
  ///   - failure: failure closure with error message
  func getConfig(completion: ((Result<Config, Error>) -> Void)?) {
    let operation = GetConfigOperation()
    operation.completionBlock = { completion?(operation.result) }
    NetworkQueue.shared.addOperation(operation: operation)
  }

  /// Get list of authentified user sessions
  ///
  /// - Parameters:
  ///   - success: success closure with the config
  ///   - failure: failure closure with error message
  func getSessions(completion: ((Result<[Session], Error>) -> Void)?) {
    let operation = GetSessionsOperation()
    operation.completionBlock = { completion?(operation.result) }
    NetworkQueue.shared.addOperation(operation: operation)
  }
}

//----------------------------------------------------------------------------
// MARK: - Table View control
//----------------------------------------------------------------------------

extension ViewController: UITableViewDelegate, UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return sessions.count
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Phase \(section + 1)"
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sessions[section]?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "session")
    let session = sessions[indexPath.section]?[indexPath.row]

    if let cell = cell as? SessionTableViewCell, let session = session {
      cell.date = dateFormatter.string(from: Date(timeIntervalSince1970: session.startedAt))
      cell.index = session.sessionId
      cell.duration = session.duration / 60
    }

    return cell!
  }

}


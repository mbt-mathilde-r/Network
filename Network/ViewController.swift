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

  var sessions = [SessionHistory]() {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }

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

    let parameters = SessionHistoryParameters(phase: 0,
                                              level: nil,
                                              _limit: nil,
                                              _skip: nil,
                                              _sort_order: nil)
    getSessionsHistory(parameters: parameters) { result in
      switch result {
      case .success(let session): self.sessions = [session]
      case .failure(let error): print("error : \(error)")
      }
    }
  }


  //----------------------------------------------------------------------------
  // MARK: - Api calls
  //----------------------------------------------------------------------------


  typealias SessionHistoryResult = Result<SessionHistory, Error>
  func getSessionsHistory(parameters: SessionHistoryParameters? = nil,
                          completion: ((SessionHistoryResult) -> Void)?) {
    let operation = GetSessionsHistoryOperation(parameters: parameters)
    operation.completionBlock = { completion?(operation.result) }
    NetworkQueue.shared.addOperation(operation: operation)
  }
}

//----------------------------------------------------------------------------
// MARK: - Table View control
//----------------------------------------------------------------------------

extension ViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sessions.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "session")
    let session = sessions[indexPath.row]

    if let cell = cell as? SessionTableViewCell {
      cell.date = dateFormatter.string(from: Date(timeIntervalSince1970: session.startedAt))
      cell.index = session.sessionId
      cell.duration = session.duration / 60
    }

    return cell!
  }

}


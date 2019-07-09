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

  var sessions = [SessionHistory]()

  //----------------------------------------------------------------------------
  // MARK: - View life cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(UINib(nibName: "SessionTableViewCell", bundle: nil),
                       forCellReuseIdentifier: "session")

    getSessionsHistory() { result in
      // 1) with switch
      switch result {
      case .success(let session):
        self.sessions = session
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      case .failure(let error): print("error : \(error)")
      }
    }

  }


  //----------------------------------------------------------------------------
  // MARK: - Api calls
  //----------------------------------------------------------------------------


  typealias SessionHistoryResult = Result<[SessionHistory], Error>
  func getSessionsHistory(completion: ((SessionHistoryResult) -> Void)?) {
    let operation = GetSessionsHistoryOperation()
    operation.completionBlock = { completion?(operation.result) }
    NetworkQueue.shared.addOperation(operation: operation)
  }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sessions.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "session")
    let session = sessions[indexPath.row]

    if let cell = cell as? SessionTableViewCell {
      cell.date = Date(timeIntervalSince1970: session.startedAt).description
      cell.index = session.sessionId
      cell.duration = session.duration / 60
    }

    return cell!
  }

}


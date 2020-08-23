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
  // MARK: - Properties
  //----------------------------------------------------------------------------

  @IBOutlet weak private var tableView: UITableView!

  private var posts = [PostModel]() {
    didSet {
      self.tableView.reloadData()
    }
  }

  private var getPostsOperation: GetPostsOperation?

  //----------------------------------------------------------------------------
  // MARK: - View life cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  private func setup() {
    setupTableView()
    setupGetPostsOperation()
  }

  private func setupTableView() {
    let nib = UINib(nibName: CustomTableViewCell.identifier, bundle: .main)
    tableView.register(nib,
                       forCellReuseIdentifier: CustomTableViewCell.identifier)
  }

  private func setupGetPostsOperation() {
    getPostsOperation = GetPostsOperation()
    getPostsOperation?.didSucceed = { [weak self] result in
      DispatchQueue.main.async {
        self?.posts = result
      }
    }

    guard let getPostsOperation = getPostsOperation else { return }
    NetworkQueue.shared.addOperation(getPostsOperation)
  }

}

//==============================================================================
// MARK: - Tableview Data source
//==============================================================================

extension ViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }

  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let identifier = CustomTableViewCell.identifier
    guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
      as? CustomTableViewCell else {
      return UITableViewCell()
    }

    let post = posts[indexPath.row]
    cell.setup(with: post)

    return cell
  }

}


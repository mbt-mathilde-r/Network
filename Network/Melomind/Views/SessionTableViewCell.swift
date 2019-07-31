//
//  SessionTableViewCell.swift
//  Network
//
//  Created by Mathilde Ressier on 09/07/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import UIKit

class SessionTableViewCell: UITableViewCell {

  //----------------------------------------------------------------------------
  // MARK: - IBOutlet
  //----------------------------------------------------------------------------
  @IBOutlet weak var indexLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var durationLabel: UILabel!

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var index: String? {
    get { return indexLabel.text }
    set { indexLabel.text = newValue }
  }

  var date: String? {
    get { return dateLabel.text }
    set { dateLabel.text = newValue }
  }

  var duration: Int? {
    get {
      guard let text = durationLabel.text else { return nil }
      return Int(text)
    }
    set { durationLabel.text = "\(newValue ?? 0)" }
  }
}

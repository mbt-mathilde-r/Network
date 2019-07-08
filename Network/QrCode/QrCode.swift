//
//  Tweet.swift
//  Network
//
//  Created by Mathilde Ressier on 08/07/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import Foundation

struct QrCode: Codable {
  let qrcode: String
  let headsetId: String

  init(qrcode: String, headsetId: String) {
    self.qrcode = qrcode
    self.headsetId = headsetId
  }
}

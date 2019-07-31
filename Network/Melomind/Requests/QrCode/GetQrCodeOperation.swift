//
//  GetTweetsOperation.swift
//  Network
//
//  Created by Mathilde Ressier on 08/07/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import Foundation

final class GetQrCodeOperation: NetworkOperation<QrCode, QrCode, GetQrCodeRequest> {
  init(qrcode: String, dependencies: [Operation]? = nil) {
    let request = GetQrCodeRequest(qrcode: qrcode)
    super.init(request: request, dependencies: dependencies)
  }
}

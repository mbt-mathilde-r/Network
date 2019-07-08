//
//  GetTweetRequest.swift
//  Network
//
//  Created by Mathilde Ressier on 08/07/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import Foundation

final class GetQrCodeRequest: RequestProtocol {

  var model: MeloRequestModel<QrCode>?

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /// Request properties
  var qrcode: String = ""

  /// Init with request properties
  ///
  /// - Parameter search: query
  init(qrcode: String) {
    self.qrcode = qrcode
  }

  //----------------------------------------------------------------------------
  // MARK: - RequestProtocol implementation
  //----------------------------------------------------------------------------

  var endpoint: String {
    return "/melomind_dev/qrcode"
  }

  var method: HTTPMethod {
    return .get
  }

  var queryType: QueryType {
    return .url
  }

  var parameters: [String : Any]? {
    return ["qrcode": qrcode]
  }
}

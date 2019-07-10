//
//  GetSessionhistory.swift
//  Network
//
//  Created by Mathilde Ressier on 08/07/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import Foundation

final class GetSessionsHistoryRequest: RequestProtocol {
  var model: MeloRequestModel<SessionHistory>?

  var endpoint: String {
    return "/sessions-history"
  }

  var method: HTTPMethod {
    return .get
  }

  var tokenType: TokenType {
    return .user
  }

  //----------------------------------------------------------------------------
  // MARK: - Parameters
  //----------------------------------------------------------------------------
  var _parameters: SessionHistoryParameters?

  var parameters: [String : Any]? {
    return _parameters.dictionary
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------
  convenience init(parameters: SessionHistoryParameters? = nil) {
    self.init()
    self._parameters = parameters
  }
}

typealias SessionHistoryNetworkOperation = NetworkOperation<
  [SessionHistory],
  SessionHistory,
  GetSessionsHistoryRequest
>

final class GetSessionsHistoryOperation: SessionHistoryNetworkOperation {
  init(parameters: SessionHistoryParameters? = nil,
       dependecies: [Operation]? = nil) {
    let request = GetSessionsHistoryRequest(parameters: parameters)
    super.init(request: request, dependencies: dependecies)
  }
}

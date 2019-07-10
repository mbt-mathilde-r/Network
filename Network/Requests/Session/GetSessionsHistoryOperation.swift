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

  var headers: [String: String]? {
    return ["Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6ImFjY2VzcyJ9.eyJ1c2VySWQiOjE5NSwiaWF0IjoxNTYyNzUwMjM4LCJleHAiOjE1NjI4MzY2MzgsImF1ZCI6Imh0dHBzOi8veW91cmRvbWFpbi5jb20iLCJpc3MiOiJmZWF0aGVycyIsInN1YiI6ImFub255bW91cyIsImp0aSI6ImMzMWEzMjMzLTBhN2UtNGVlZi1hYTBjLTY4YzhkOTE0Y2U0OSJ9.GZfnKuwcHnEsnO65U2ZbRgQsWv9inLAEycdM8BHNvtQ"]
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

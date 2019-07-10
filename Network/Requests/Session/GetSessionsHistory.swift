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
    return "/melomind_dev/sessions-history"
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

final class GetSessionsHistoryOperation: NetworkOperation<
  [SessionHistory],
  SessionHistory,
  GetSessionsHistoryRequest
> {
  init(dependecies: [Operation]? = nil) {
    let request = GetSessionsHistoryRequest()
    super.init(request: request, dependencies: dependecies)
  }
}

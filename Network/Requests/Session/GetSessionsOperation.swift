//
//  GetSessionsOperation.swift
//  Network
//
//  Created by Mathilde Ressier on 08/07/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import Foundation

final class GetSessionsRequest: RequestProtocol {
  var model: MeloRequestModel<Session>?

  var endpoint: String {
    return "/sessions"
  }

  var method: HTTPMethod {
    return .get
  }

  var headers: [String: String]? {
    return ["Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6ImFjY2VzcyJ9.eyJ1c2VySWQiOjE5NSwiaWF0IjoxNTYyNzUwMjM4LCJleHAiOjE1NjI4MzY2MzgsImF1ZCI6Imh0dHBzOi8veW91cmRvbWFpbi5jb20iLCJpc3MiOiJmZWF0aGVycyIsInN1YiI6ImFub255bW91cyIsImp0aSI6ImMzMWEzMjMzLTBhN2UtNGVlZi1hYTBjLTY4YzhkOTE0Y2U0OSJ9.GZfnKuwcHnEsnO65U2ZbRgQsWv9inLAEycdM8BHNvtQ"]
  }

  var parameters: [String : Any]? { return nil }
}

final class GetSessionsOperation: NetworkOperation<[Session], Session, GetSessionsRequest>{
  init(dependecies: [Operation]? = nil) {
    let request = GetSessionsRequest()
    super.init(request: request, dependencies: dependecies)
  }
}
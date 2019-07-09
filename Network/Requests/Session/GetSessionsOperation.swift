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
    return "/melomind_dev/sessions"
  }

  var method: HTTPMethod {
    return .get
  }

  var headers: [String: String]? {
    return ["Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6ImFjY2VzcyJ9.eyJ1c2VySWQiOjkwLCJpYXQiOjE1NjI1OTkzODEsImV4cCI6MTU2MjY4NTc4MSwiYXVkIjoiaHR0cHM6Ly95b3VyZG9tYWluLmNvbSIsImlzcyI6ImZlYXRoZXJzIiwic3ViIjoiYW5vbnltb3VzIiwianRpIjoiY2U2Mjc2NGMtNjQ0Zi00MjRmLWJjNzQtZGM3ODg5ZjhiYzVkIn0.7aDILvFJA7xm1IJlwpkx087QuLGH3W1nwjmcFOX3mLw"]
  }

  var parameters: [String : Any]? { return nil }
}

final class GetSessionsOperation: NetworkOperation<MeloRequestModel<Session>?, GetSessionsRequest> {
  init(dependecies: [Operation]? = nil) {
    let request = GetSessionsRequest()
    super.init(request: request, dependencies: dependecies)
  }
}

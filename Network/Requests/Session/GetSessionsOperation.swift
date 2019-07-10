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

  var tokenType: TokenType {
    return .user
  }

  var parameters: [String : Any]? { return nil }
}

final class GetSessionsOperation: NetworkOperation<[Session], Session, GetSessionsRequest>{
  init(dependecies: [Operation]? = nil) {
    let request = GetSessionsRequest()
    super.init(request: request, dependencies: dependecies)
  }
}

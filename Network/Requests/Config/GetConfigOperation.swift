//
//  GetConfig.swift
//  Network
//
//  Created by Mathilde Ressier on 08/07/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import Foundation

final class GetConfigRequest: RequestProtocol {
  var model: MeloRequestModel<Config>?

  var endpoint: String {
    return "/config"
  }

  var method: HTTPMethod {
    return .get
  }

  var tokenType: TokenType {
    return .user
  }

  var parameters: [String : Any]? { return nil }
}

final class GetConfigOperation: NetworkOperation<Config, Config, GetConfigRequest> {
  init(dependecies: [Operation]? = nil) {
    let request = GetConfigRequest()
    super.init(request: request, dependencies: dependecies)
  }
}

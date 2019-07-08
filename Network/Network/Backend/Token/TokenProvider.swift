//
//  TokenProvider.swift
//  Network
//
//  Created by Laurent on 03/07/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import Foundation

final class TokenProvider {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------
  // MARK: - Token
  //----------------------------------------------------------------------------

  func token(ofType tokenType: TokenType) -> String {
    switch (tokenType) {
    case .admin:
      return "serviceToken"
    case .none:
      return ""
    case .user:
      return "userToken"
    }
  }

}

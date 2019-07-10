//
//  ApiTokenProviderTests.swift
//  NetworkTests
//
//  Created by Laurent on 10/07/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import XCTest
@testable import Network

class ApiTokenProviderTests: XCTestCase {


  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  let bearerText = "Bearer"

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override func setUp() {
  }

  override func tearDown() {
  }


  //----------------------------------------------------------------------------
  // MARK: - Tests
  //----------------------------------------------------------------------------

  private func setAndGetToken(_ token: String, for type: TokenType) -> String {
    ApiTokenProvider.shared.setToken(token, for: type)
    return ApiTokenProvider.shared.token(for: type)
  }

  func testSetToken() {
    let tokenToType: [String: TokenType] = [
      "" : .none,
      "user": .user,
      "admin": .admin
    ]

    for item in tokenToType {
      let expectedResults = "\(bearerText) \(item.key)"
      let result = setAndGetToken(item.key, for: item.value)
      XCTAssertTrue(expectedResults == result)
    }

  }



}

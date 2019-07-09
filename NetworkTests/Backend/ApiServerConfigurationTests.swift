//
//  ApiServerConfigurationTests.swift
//  NetworkTests
//
//  Created by Laurent on 09/07/2019.
//  Copyright © 2019 Laurent Noudohounsi. All rights reserved.
//

import XCTest
@testable import Network

class ApiServerConfigurationTests: XCTestCase {

  func testBaseUrl() {
    let expectedUrl = "https://api.devz.mybraintech.com"
    guard let url = ApiServerConfiguration.shared.baseURL.url else {
      XCTFail("Couldn't get the base url")
      return
    }

    XCTAssertTrue(expectedUrl == url.absoluteString)
  }

  func testVersion() {
    let expectedVersion = "/melomind_dev"
    let version = ApiServerConfiguration.shared.version
    XCTAssertTrue(expectedVersion == version)
  }

}

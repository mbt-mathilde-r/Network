import XCTest
@testable import Network

class ApiServerConfigurationTests: XCTestCase {

  func testBaseUrl() {
    let expectedUrl = "https://jsonplaceholder.typicode.com"
    guard let url = ApiServerConfiguration.shared.baseURL.url else {
      XCTFail("Couldn't get the base url")
      return
    }

    XCTAssertTrue(expectedUrl == url.absoluteString)
  }

  func testVersion() {
    let expectedVersion = ""
    let version = ApiServerConfiguration.shared.version
    XCTAssertTrue(expectedVersion == version)
  }

}




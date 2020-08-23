import XCTest
@testable import Network

extension UrlSessionApiService: UrlSessionApiServiceTestable { }

class UrlSessionApiServiceTests: XCTestCase {

  func testServiceSuccess() {
    let expectation = XCTestExpectation(description: #function)

    let mockServiceProvider = MockServiceProvider()

    XCTAssert(mockServiceProvider.isInitialized == false)
    let apiService = UrlSessionApiService(service: MockServiceProvider())

    apiService.setupForMock() { result in
      if result {
        expectation.fulfill()
      } else {
        XCTFail()
      }
    }

    let result = XCTWaiter.wait(for: [expectation], timeout: 3)
    XCTAssert(result == .completed, "Expectation error")
  }

}

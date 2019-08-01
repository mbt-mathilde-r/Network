import XCTest
@testable import Network

extension UrlSessionApiService: UrlSessionApiServiceTestable { }

class UrlSessionApiServiceTests: XCTestCase {

  func testService() {
    let mockServiceProvider = MockServiceProvider()

    XCTAssert(mockServiceProvider.isInitialized == false)
    let apiService = UrlSessionApiService(service: MockServiceProvider())

    apiService.setupForMock() { result in
      XCTAssert(result == true)
    }

    //while true { }
  }

}

import XCTest
@testable import Network

final class TestGetRequest: ApiRequestProtocol {

  var endpoint: String {
    return "endpoint"
  }

  var method: HTTPMethod {
    return .get
  }

  var tokenType: TokenType {
    return .none
  }

  var parameters: [String : Any]?

}

class ApiRequestTests: XCTestCase {

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


  func testGet() {
  }

}

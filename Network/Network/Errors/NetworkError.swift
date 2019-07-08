import Foundation

enum NetworkError : Error {

  //----------------------------------------------------------------------------
  // MARK: - Cases
  //----------------------------------------------------------------------------

  case NetworkError
  case InvalidJSON
  case InvalidHTTPURLResponse(response: HTTPURLResponse)
  case couldNotGenerateURL
  case invalidResult

  //----------------------------------------------------------------------------
  // MARK: - Validity
  //----------------------------------------------------------------------------

  static func isValidResponse(response: HTTPURLResponse) -> Bool {
//    guard let httpResponse = response as? HTTPURLResponse else {
//      print("Error while converting URLResponse")
//      return false
//    }

    let isValidResponse = 200...299 ~= response.statusCode
    return isValidResponse
  }

}

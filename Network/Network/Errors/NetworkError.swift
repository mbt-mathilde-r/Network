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
  case invalidEnvelopeData

}

enum URLSessionError: Error {

  //----------------------------------------------------------------------------
  // MARK: - Cases
  //----------------------------------------------------------------------------

  case notAHttpUrlResponse
  case invalidHTTPURLResponse(response: HTTPURLResponse)
  case emptyData

}

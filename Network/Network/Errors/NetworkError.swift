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

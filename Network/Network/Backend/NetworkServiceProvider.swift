import Foundation

/*******************************************************************************
 * NetworkServiceProvider
 *
 * Allows you to execute HTTP request, it incorporates NSURLSession internally.
 * Every network service can execute just one request at a time, can cancel the
 * request (big advantage), and has callbacks for success and failure responses.
 *
 ******************************************************************************/

final class NetworkServiceProvider: NSObject, NetworkServiceProviderProtocol {

  //----------------------------------------------------------------------------
  // MARK: - Typealias
  //----------------------------------------------------------------------------

  private typealias DataTaskResult =
    (data: Data?, response: URLResponse?, error: Error?)

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** URLSession ********************/

  private var task: URLSessionDataTask?

  private var timeoutInterval: TimeInterval = 10.0

  //----------------------------------------------------------------------------
  // MARK: - Task life cycle
  //----------------------------------------------------------------------------

  func setup(urlRequest: URLRequest,
             completion: @escaping ((Result<Data, Error>) -> Void)) {
    task = URLSession.shared.dataTask(with: urlRequest) {
      data, response, error in
      defer { self.task = nil }
      //print("\(urlRequest.url?.absoluteString ?? "wrong url") task completed.")
      switch self.isValid(dataTaskResult: (data, response, error)) {
        case .failure(let failureError): completion(.failure(failureError))
        case .success(let valideData): completion(.success(valideData))
      }
    }
  }

  func start() {
    let url = task?.currentRequest?.url?.absoluteString ?? "wrong url"
    print("\(url) task starts.")

    task?.resume()
  }

  func cancel() {
    task?.cancel()
  }

  //----------------------------------------------------------------------------
  // MARK: - Validity
  //----------------------------------------------------------------------------

  /// Check if a given http response is valid or not.
  /// - Parameter response: A http response to check.
  /// - Returns: True if valide, false otherwise.
  private func isValidResponse(response: HTTPURLResponse) -> Bool {
    let isValidResponse = 200...299 ~= response.statusCode
    return isValidResponse
  }

  /// Check if a task result is valid or not.
  /// - Parameter dataTaskResult: A task resul to check.
  /// - Returns: True if valide, false otherwise.
  private func isValid(dataTaskResult: DataTaskResult) -> Result<Data, Error> {
    if let error = dataTaskResult.error { return .failure(error) }

    guard let response = dataTaskResult.response as? HTTPURLResponse else {
      return .failure(URLSessionError.notAHttpUrlResponse)
    }

    guard isValidResponse(response: response) == true else {
      let error = URLSessionError.invalidHTTPURLResponse(response: response)
      return .failure(error)
    }

    //print("response:\n\(response)")

    guard let data = dataTaskResult.data else {
      return .failure(URLSessionError.emptyData)
    }

    return .success(data)
  }

}

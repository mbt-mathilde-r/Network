import Foundation

// Without JWTDecode: https://stackoverflow.com/a/40915703/2448287


// Backend Network provider. URLSession but could be Alamofire or other

enum URLSessionError: Error {
  case notAHttpUrlResponse
  case invalidHTTPURLResponse(response: HTTPURLResponse)
  case emptyData
}


//allows you to execute HTTP request, it incorporates NSURLSession internally.
//Every network service can execute just one request at a time, can cancel the
//request (big advantage), and has callbacks for success and failure responses.
class NetworkServiceProvider: NSObject {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Typealias ********************/

  private typealias DataTaskResult =
    (data: Data?, response: URLResponse?, error: Error?)

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
//      print("\(urlRequest.url?.absoluteString ?? "wrong url") task completed.")
      self.isValidResponse(dataTaskResult: (data, response, error)) {
        result in
        switch result {
        case .failure(let failureError): completion(.failure(failureError))
        case .success(let valideData): completion(.success(valideData))
        }
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

  private func isValidResponse(
    dataTaskResult: DataTaskResult,
    completion: @escaping ((Result<Data, Error>) -> Void)) {
    if let error = dataTaskResult.error {
      completion(.failure(error))
      return
    }

    guard let response = dataTaskResult.response as? HTTPURLResponse else {
      completion(.failure(URLSessionError.notAHttpUrlResponse))
      return
    }

    guard NetworkError.isValidResponse(response: response) == true else {
      let error = URLSessionError.invalidHTTPURLResponse(response: response)
      completion(.failure(error))
      return
    }
    //print("response:\n\(response)")

    guard let data = dataTaskResult.data else {
      completion(.failure(URLSessionError.emptyData))
      return
    }

    completion(.success(data))
  }

}

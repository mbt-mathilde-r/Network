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
class NetworkServiceProvider: NSObject, URLSessionTaskDelegate {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  private var task: URLSessionDataTask?
  private var timeoutInterval: TimeInterval = 10.0

  var shouldCancel = false

  func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
    print("Waiting for network")
  }


  //----------------------------------------------------------------------------
  // MARK: - Validity
  //----------------------------------------------------------------------------

  func isValidResponse(data: Data?,
                       response: URLResponse?,
                       error:Error?,
                       completion: @escaping ((Result<Data, Error>) -> Void)) {
    if let error = error {
      completion(.failure(error))
      return
    }

    guard let response = response as? HTTPURLResponse else {
      completion(.failure(URLSessionError.notAHttpUrlResponse))
      return
    }

    guard NetworkError.isValidResponse(response: response) == true else {
      completion(
        .failure(URLSessionError.invalidHTTPURLResponse(response: response)))
      return
    }
    //print("response:\n\(response)")

    guard let data = data else {
      completion(.failure(URLSessionError.emptyData))
      return
    }

    completion(.success(data))
  }

  //----------------------------------------------------------------------------
  // MARK: - Task life cycle
  //----------------------------------------------------------------------------

  func setup(urlRequest: URLRequest,
             completion: @escaping ((Result<Data, Error>) -> Void)) {

    task = URLSession.shared.dataTask(with: urlRequest) {
      data, response, error in
      defer { self.task = nil }
//      print("\(urlRequest.url?.absoluteString ?? "wrong url") task completed.")
      self.isValidResponse(data: data, response: response, error: error) {
        result in
        switch result {
        case .failure(let failureError): completion(.failure(failureError))
        case .success(let valideData): completion(.success(valideData))
        }
      }
    }
  }

  func start() {
    print("\(task?.currentRequest?.url?.absoluteString ?? "wrong url") task starts.")
    task?.resume()
  }

//  func start(urlRequest: URLRequest,
//             completion: @escaping ((Result<Data, Error>) -> Void)) {
//    task = URLSession.shared.dataTask(with: urlRequest) {
//      data, response, error in
//      defer { self.task = nil }
//      print("URLSession task starts.")
//      self.isValidResponse(data: data, response: response, error: error) {
//        result in
//        switch result {
//        case .failure(let failureError): completion(.failure(failureError))
//        case .success(let valideData): completion(.success(valideData))
//        }
//      }
//    }
//
//    task?.resume()
//
//    if shouldCancel {
//      task?.cancel()
//      shouldCancel = false
//    }
//  }
//
//  // Rename to 'start'
//  func request(url: URL,
//               method: HTTPMethod,
//               parameters: [String: Any]? = nil,
//               headers: [String: String]? = nil,
//               completion: @escaping ((Result<Data, Error>) -> Void)) {
//    let urlRequest = createUrlRequest(url: url,
//                                      method: method,
//                                      parameters: parameters,
//                                      headers: headers)
//    task = URLSession.shared.dataTask(with: urlRequest) {
//      data, response, error in
//      defer { self.task = nil }
//      print("URLSession task starts.")
//      self.isValidResponse(data: data, response: response, error: error) {
//        result in
//        switch result {
//        case .failure(let failureError): completion(.failure(failureError))
//        case .success(let valideData): completion(.success(valideData))
//        }
//      }
//    }
//
//    task?.resume()
//  }


  func cancel() {
    if task == nil {
      shouldCancel = true
    } else {
      task?.cancel()
    }

  }

  //----------------------------------------------------------------------------
  // MARK: - Request builder
  //----------------------------------------------------------------------------

  private func generateUrlRequest(url: URL,
                                  request: ApiRequestProtocol) -> URLRequest {
    var urlRequest =
      URLRequest(url: url,
                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, // ToCheck
                 timeoutInterval: timeoutInterval)

    urlRequest.httpMethod = request.method.rawValue
    urlRequest.allHTTPHeaderFields = request.headers
    urlRequest.httpBody = request.httpBody

    return urlRequest
  }

  private func createUrlRequest(
    url: URL,
    method: HTTPMethod,
    parameters: [String: Any]? = nil,
    headers: [String: String]? = nil
    ) -> URLRequest {

    // asURLRequest in Melomind
    var urlRequest =
      URLRequest(url: url,
                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                 timeoutInterval: timeoutInterval)

    urlRequest.allHTTPHeaderFields = headers
    urlRequest.httpMethod = method.rawValue

    // TODO: handle PUT and PATCH
    if method == .post, let parameters = parameters {
      urlRequest.httpBody =
        try? JSONSerialization.data(withJSONObject: parameters, options: [])
    }

    setRequestAuthorization(urlRequest: &urlRequest)

    return urlRequest
  }

  private func setRequestAuthorization(urlRequest: inout URLRequest) {
    // https://symfonycasts.com/screencast/rest-ep2/authentication-via-token
    // https://swagger.io/docs/specification/authentication/bearer-authentication/
    // https://www.thefuturetrends.com/http-get-request-using-auth-header-token-in-swift3/
    let token = ""
    urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
  }

}

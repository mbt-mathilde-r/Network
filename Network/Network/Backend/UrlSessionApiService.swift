import Foundation

//the class that takes requests related to the backend.
//It uses NetworkService internally.

/*******************************************************************************
 * UrlSessionApiService
 *
 * Use Request to feed an URLSession network service provider.
 *
 ******************************************************************************/

class UrlSessionApiService: ApiServiceProtocol {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  private let configuration: ApiConfiguration
  private let service = NetworkServiceProvider()

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(configuration: ApiConfiguration = ApiConfiguration.shared) {
    self.configuration = configuration
  }

  //----------------------------------------------------------------------------
  // MARK: - Requests
  //----------------------------------------------------------------------------

  func setup(with request: ApiRequestProtocol,
               completion: @escaping ((Result<Data, Error>) -> Void)) {

    guard let urlRequest =
      UrlRequestBuilder.buildUrlRequest(from: request,
                                        apiConfiguration: configuration,
                                        timeoutInterval: 10)
      else {
        completion(.failure(NetworkError.couldNotGenerateURL))
        return
    }

    service.setup(urlRequest: urlRequest) { result in
      switch result {
      case .success(let data):
        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func start() {
    service.start()
  }

  func cancel() {
    service.cancel()
  }

}

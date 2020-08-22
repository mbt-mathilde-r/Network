import Foundation

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

  private let configuration: ApiServerConfiguration
  private let service: NetworkServiceProviderProtocol

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(configuration: ApiServerConfiguration = ApiServerConfiguration.shared,
       service: NetworkServiceProviderProtocol = NetworkServiceProvider()) {
    self.configuration = configuration
    self.service = service
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
        case .success(let data): completion(.success(data))
        case .failure(let error): completion(.failure(error))
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










protocol UrlSessionApiServiceTestable {

  func setupForMock(completion: @escaping ((Bool) -> Void))
}

extension UrlSessionApiServiceTestable where Self: UrlSessionApiService {

  func setupForMock(completion: @escaping ((Bool) -> Void)) {
    let dumbRequest = GetPostRequest(postId: 1)
    setup(with: dumbRequest) { result in
      switch result {
      case .success(_): completion(true)
      case .failure(_): completion(false)
      }
    }
  }

}

import Foundation

class MockServiceProvider: NetworkServiceProviderProtocol {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var isInitialized = false
  var isStarted = false
  var isCancelled = false

  var shouldSucced = true

  //----------------------------------------------------------------------------
  // MARK: - Task life cycle
  //----------------------------------------------------------------------------

  func setup(urlRequest: URLRequest,
             completion: @escaping ((Result<Data, Error>) -> Void)) {
    if shouldSucced {
      let data = Data(repeating: 5, count: 5)
      completion(.success(data))
    } else {
      completion(.failure(NetworkError.invalidResult))
    }
  }

  func start() {
    isStarted = true
  }

  func cancel() {
    isCancelled = true
  }

}

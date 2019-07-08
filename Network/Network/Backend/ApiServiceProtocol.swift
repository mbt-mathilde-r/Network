import Foundation

protocol ApiServiceProtocol {

  func setup(with request: ApiRequestProtocol,
             completion: @escaping ((Result<Data, Error>) -> Void))

  func start()
  func cancel()

}

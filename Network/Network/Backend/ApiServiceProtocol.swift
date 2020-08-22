import Foundation

/*******************************************************************************
 * ApiServiceProtocol
 *
 * A type that can be used as API
 *
 ******************************************************************************/

protocol ApiServiceProtocol {

  /// Setup the service to handle the life cycle of a given request.
  /// - Parameters:
  ///   - request: The request to use.
  ///   - completion: Called when the request is finished.
  func setup(with request: ApiRequestProtocol,
             completion: @escaping ((Result<Data, Error>) -> Void))

  /// Start the current request.
  func start()

  /// Cancel the current request.
  func cancel()

}

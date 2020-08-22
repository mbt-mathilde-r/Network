import Foundation

/*******************************************************************************
 * NetworkServiceProviderProtocol
 *
 * A type that can provide a network service (i.e URLSession, Alamofire, ...)
 *
 ******************************************************************************/

protocol NetworkServiceProviderProtocol {

  func setup(urlRequest: URLRequest,
             completion: @escaping ((Result<Data, Error>) -> Void))

  func start()

  func cancel()
}

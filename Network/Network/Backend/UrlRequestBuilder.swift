import Foundation

/*******************************************************************************
 * UrlRequestBuilder
 *
 * Generate a URLRequest from a request that conforms to ApiRequestProtocol
 * for an URLSessionTask.
 *
 ******************************************************************************/

final class UrlRequestBuilder {

  //----------------------------------------------------------------------------
  // MARK: - Builder
  //----------------------------------------------------------------------------

  static func buildUrlRequest(from request: ApiRequestProtocol,
                              apiConfiguration: ApiServerConfiguration,
                              timeoutInterval: TimeInterval) -> URLRequest? {
    guard let url =
      UrlRequestBuilder.generateUrl(from: request,
                                    apiConfiguration: apiConfiguration)
      else {
        // TODO: Create error
        print("Error while generating url")
        return nil
    }

    var urlRequest = URLRequest(url: url,
                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, // ToCheck
                 timeoutInterval: timeoutInterval)

    // let headers = request.headers
    // Set authentication token if available.
    // headers?["X-Api-Auth-Token"] = BackendAuth.shared.token

    urlRequest.httpMethod = request.method.rawValue
    urlRequest.allHTTPHeaderFields = request.headers
    urlRequest.httpBody = request.httpBody

    return urlRequest
  }

  /// Generate the full url of a given request for a specific configuration.
  /// - Parameters:
  ///   - request: The request to use.
  ///   - apiConfiguration: The related request configuration.
  /// - Returns: A generated request url.
  private static func generateUrl(
    from request: ApiRequestProtocol,
    apiConfiguration: ApiServerConfiguration
  ) -> URL? {
    var urlComponent = apiConfiguration.baseURL
    urlComponent.path = request.endpoint // apiConfiguration.version + request.endpoint
    urlComponent.percentEncodedQuery = request.query

    guard let url = urlComponent.url else {
      // TODO: Create error
      print("Could not create url")
      return nil
    }

    return url
  }

}

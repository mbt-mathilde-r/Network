import Foundation

/*******************************************************************************
 * UrlRequestBuilder
 *
 * Generate a URLRequest from a request that conforms to ApiRequestProtocol
 * for an URLSessionTask.
 *
 ******************************************************************************/

class UrlRequestBuilder {

  //----------------------------------------------------------------------------
  // MARK: - Builder
  //----------------------------------------------------------------------------

  static func buildUrlRequest(from request: ApiRequestProtocol,
                              apiConfiguration: ApiConfiguration,
                              timeoutInterval: TimeInterval) -> URLRequest? {
    guard let url =
      UrlRequestBuilder.generateUrl(from: request,
                                    apiConfiguration: apiConfiguration) else {
        print("Error while generating url")
        return nil
    }

    var urlRequest =
      URLRequest(url: url,
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

  private static func generateUrl(from request: ApiRequestProtocol,
                                  apiConfiguration: ApiConfiguration) -> URL? {
    var urlComponent = apiConfiguration.baseURL
    urlComponent.path = request.endpoint
    urlComponent.percentEncodedQuery = request.query

    guard let url = urlComponent.url else {
      // TODO: Create error
      print("Could not create url")
      return nil
    }

//    print("url: \(url)")
    return url
  }

}

import Foundation


/*******************************************************************************
 * NetworkOperation
 *
 * A network operation used
 * ResultSuccessType is the type of data expected as result.
 * EnvelopeDataItemType is the type of the enveloppe of the expected data.
 * /!\ Enveloppes are not used in this project.
 * RequestType is the type of the request that will be made to receive the data.
 *
 ******************************************************************************/

class NetworkOperation<
  ResultSuccessType: Codable,
  EnvelopeDataItemType: Codable,
  RequestType: ApiRequestProtocol
>: AsynchronousBlockOperation {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Typealias ********************/

  typealias ResultType = Result<ResultSuccessType, Error>

  /******************** Services ********************/

  private let service = UrlSessionApiService()

  var request: RequestType

  /******************** Result ********************/

  /// Closure called when a operation succefully finished.
  /// Called in background thread.
  var didSucceed: ((ResultSuccessType) -> Void)?

  /// Closure called when a operation unsuccefully finished.
  /// Called in background thread.
  var didFail: ((Error) -> Void)?

  /// Completion block called in main thread. Sugar syntax for UI completion.
  var completionBlockInMainThread: ((ResultType) -> Void)?

  private(set) var result: ResultType
    = ResultType.failure(NetworkError.invalidResult) {
    didSet {

      // Callback in background completionBlock.
      switch result {
        case .success(let data): didSucceed?(data)
        case .failure(let error): didFail?(error)
      }

      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        self.completionBlockInMainThread?(self.result)
      }

      finish()
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(request: RequestType, dependencies: [Operation]?) {
    self.request = request
    super.init()
    setup(dependencies: dependencies, shouldAddToNetworkQueue: false)
  }

  private func setup(dependencies: [Operation]?,
                     shouldAddToNetworkQueue: Bool) {
    dependencies?.forEach() { addDependency($0) }
    setupRequest()

    if shouldAddToNetworkQueue {
      NetworkQueue.shared.addOperation(self)
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Request
  //----------------------------------------------------------------------------

  private func setupRequest() {
    service.setup(with: request) { [weak self] result in
      switch result {
        case .failure(let error): self?.handleFailure(error: error)
        case .success(let data): self?.handleSuccess(data: data)
      }
    }
  }

  /// Called when a request successfully finished.
  /// - Parameter data: The received data.
  private func handleSuccess(data: Data) {
    do {
      // TODO: move data decoding into request.
      // Not used here since no envelopes are present.
      // let item =
      //  try JsonEnvelopeDecoder<ResultSuccessType, EnvelopeDataItemType>
      //    .decode(data: data)

      let item = try JSONDecoder().decode(ResultSuccessType.self, from: data)
      result = ResultType.success(item)
    } catch {
      handleFailure(error: error)
    }
  }


  /// Called when a request unsuccessfully finished.
  /// - Parameter error: The received error.
  private func handleFailure(error: Error) {
    result = ResultType.failure(error)
  }

  //----------------------------------------------------------------------------
  // MARK: - Operation life cycle
  //----------------------------------------------------------------------------

  override func main() {
    service.start()
  }

  override func cancel() {
    super.cancel()
    service.cancel()
  }

}

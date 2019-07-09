import Foundation

class NetworkOperation<
    ResultSuccessType,
    DataItemType: Codable,
    RequestType: ApiRequestProtocol
>: AsynchronousBlockOperation {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Typealias ********************/

  typealias ResultType = Result<ResultSuccessType, Error>

  /******************** Services ********************/

  private let service = UrlSessionApiService()

  private var request: RequestType

  /******************** Result ********************/

  var success: ((ResultSuccessType) -> Void)?

  var failure: ((Error) -> Void)?

  private(set) var result: ResultType
    = ResultType.failure(NetworkError.invalidResult)  {
    didSet {
      finish()
      switch result {
      case .success(let data): success?(data)
      case .failure(let error): failure?(error)
      }
    }
  }

  var isResultSuccessTypeArray: Bool {
    return ResultSuccessType.self is Array<DataItemType>.Type
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
      NetworkQueue.shared.addOperation(operation: self)
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

  private func handleSuccess(data: Data) {
    do {
      let envelope =
        try JSONDecoder().decode(MeloRequestModel<DataItemType>.self,
                                 from: data)

      if isResultSuccessTypeArray {
        guard let item = envelope.data as? ResultSuccessType else {
          handleFailure(error: NetworkError.invalidEnvelopeData)
          return
        }
        result = ResultType.success(item)
      } else {
        guard let item = envelope.data.first as? ResultSuccessType else {
          handleFailure(error: NetworkError.invalidEnvelopeData)
          return
        }
        result = ResultType.success(item)
      }
      
    } catch {
      handleFailure(error: error)
    }
  }

  private func handleFailure(error: Error) {
    result = ResultType.failure(error)
  }

  //----------------------------------------------------------------------------
  // MARK: - Operation life cycle
  //----------------------------------------------------------------------------

  override func main() {
    service.start()
    //    sleep(1)
  }

  override func cancel() {
    super.cancel()
    service.cancel()
  }

  //----------------------------------------------------------------------------
  // MARK: - Shitty Utility
  //----------------------------------------------------------------------------



}

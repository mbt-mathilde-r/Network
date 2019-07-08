//final class GetTokenRequest: RequestProtocol {
//
//  //----------------------------------------------------------------------------
//  // MARK: - Properties
//  //----------------------------------------------------------------------------
//
//  private(set) var model: UserModel?
//
//  //----------------------------------------------------------------------------
//  // MARK: - Initialization
//  //----------------------------------------------------------------------------
//
//  init(name: String, email: String) {
//    model = UserModel(name: name, email: email)
//  }
//
//  //----------------------------------------------------------------------------
//  // MARK: - BackendAPIRequest
//  //----------------------------------------------------------------------------
//
//  var endpoint: String {
//    // TODO: Handle error
//    guard let name = model?.name else { return "" }
//    return "/users/\(name)"
//  }
//
//  var method: HTTPMethod {
//    return .get
//  }
//
//  var queryType: QueryType {
//    return .url
//  }
//
//  var parameters: [String: Any]? {
//    return model.dictionary
//  }
//
//}


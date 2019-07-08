import Foundation

protocol RequestProtocol: ApiRequestProtocol {

  associatedtype ModelType: Codable
  var model: ModelType? { get }

}

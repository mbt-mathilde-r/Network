import Foundation


/*******************************************************************************
 * RequestProtocol
 *
 * A type that represente an API request with a type of expected data.
 *
 ******************************************************************************/

protocol RequestProtocol: ApiRequestProtocol {

  associatedtype ModelType: Codable
  var model: ModelType? { get }

}

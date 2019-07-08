import Foundation

extension Encodable {

  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    let jsonObject = try? JSONSerialization.jsonObject(with: data,
                                                       options: .allowFragments)
    return jsonObject.flatMap { $0 as? [String: Any] }
  }

}

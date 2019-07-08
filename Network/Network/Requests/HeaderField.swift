import Foundation

enum HeaderField {

  case contentType
  case authorization

  var rawValue: (key: String, value: String) {
    switch self {
    case .contentType:
      return ("Content-Type", "application/json")
    case .authorization:
      fatalError("To be implemented.")
    }
  }

}

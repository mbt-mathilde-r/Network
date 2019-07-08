import Foundation

struct PostModel: Codable {

  var id: Int? = nil
  var userId: Int
  var title: String
  var body: String

  init(id: Int? = nil, userId: Int, title: String, body: String) {
    self.id = id
    self.userId = userId
    self.title = title
    self.body = body
  }
}

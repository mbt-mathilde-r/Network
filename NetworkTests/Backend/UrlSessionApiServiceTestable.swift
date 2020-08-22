import Foundation

protocol UrlSessionApiServiceTestable {
  func setupForMock(completion: @escaping ((Bool) -> Void))
}

extension UrlSessionApiServiceTestable where Self: UrlSessionApiService {

  func setupForMock(completion: @escaping ((Bool) -> Void)) {
    let dumbRequest = GetPostRequest(postId: 1)
    setup(with: dumbRequest) { result in
      switch result {
      case .success(_): completion(true)
      case .failure(_): completion(false)
      }
    }
  }

}

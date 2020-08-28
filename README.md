# Network

The purpose of this code is a work in progress that aim to be a clean and user-friendly network RestAPI.

Every RestAPI calls can be started, cancelled or combined easily.The main goal is: simple usage for everyone.

Any developer from all level could create a network request and use it in less than 10 minutes.

Please note that slides of the talk can be found in this repo. You will find more information and images.

## Structure

Thi network architecture rely on the power of operation to create asynchronous network call that can be dependent on each other.

The architecture is divided in 3 parts

1) Network service 
2) Request
3) Network operation

Having these different modules enables a better encapsulation and testability.

For instance, we can switch from URLSession to Alamofire with just one line (and a new wrapper).

## Network service

Handle the network call provider, RestAPI configuration, authentication.
Using a request, it will setup and launch an RestAPI call. 


## Request

Take care of the creation of an RestAPI request based on a protocol:

```swift
protocol ApiRequestProtocol {
  var endpoint: String { get }
  var method: HTTPMethod { get }
  var queryType: QueryType { get }
  var query: String? { get }
  var tokenType: TokenType { get }
  var headers: [String: String]? { get }
  var httpBody: Data? { get }
  var parameters: [String: Any]? { get }
}
```

Any request will conform to it.

```swift
let getRequest = GetPostRequest(postId: 13)

// URLSession is used as a network service
let urlSessionApiService = UrlSessionApiService()

// The service is setup with a GET request.
urlSessionApiService.setup(with: getRequest) { result in
    switch result {
      case .failure(_): print("Success")
      case .success(_): print("Failure")
    }
}

// The GET call is launched.
urlSessionApiService.start()
```

## Network operation

A network operation is a wrapper around network service and request.

Based on Swift Operation, it  

```Swift
final class GetPostOperation: NetworkOperation<PostModel, GetPostRequest> {

  init(postId: Int, dependencies: [Operation]? = nil) {
    let request = GetPostRequest(postId: postId)
    super.init(request: request, dependencies: dependencies)
  }
  
} 
```

## Example

Here is an example of a simple GET operation that fetch a post.

```Swift
let getPostOperation = GetPostOperation(postId: 13)

getPostOperation.didSucceed = { post in print(post) }

getPostOperation.didFail = { error in print(error) }

NetworkQueue.shared.addOperation(getPostOperation)
```

More examples (like dependencies, cancellation, batching, combined operation, and more) can be found at the `NetworkTests.swift`.

Also a (almost) real world example can be found in `ViewController.swift`

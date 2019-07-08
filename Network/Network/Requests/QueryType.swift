import Foundation

/// The differents types of query.
/// https://idratherbewriting.com/learnapidoc/docapis_doc_parameters.html#request_body_parameters
/// - path: Add the parameters as query in the URL (usually for GET)
/// - json: Add the parameters in a Json inside the HTTP body request (usually
/// for POST).

// https://stackoverflow.com/a/17999251/2448287

enum QueryType {
  case url
  case body
}

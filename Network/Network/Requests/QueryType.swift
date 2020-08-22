import Foundation

/*******************************************************************************
 * QueryType
 *
 * The differents types of query in order to know where to use the parameters.
 *
 * Ref: https://stackoverflow.com/a/17999251/2448287
 * https://idratherbewriting.com/learnapidoc/docapis_doc_parameters.html#request_body_parameters
 *
 ******************************************************************************/

enum QueryType {

  /// Add the parameters as query in the URL (usually for GET)
  case url

  /// Add the parameters in a Json inside the HTTP body request (usually for
  /// POST).
  case body
  
}

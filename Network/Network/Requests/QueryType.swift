import Foundation

/*******************************************************************************
 * QueryType
 *
 * The differents types of query in order to know where to use the parameters.
 *
 ******************************************************************************/

enum QueryType {

  /// Add the parameters as query in the URL (usually for GET)
  case url

  /// Add the parameters in a Json inside the HTTP body request (usually for
  /// POST).
  case body
  
}

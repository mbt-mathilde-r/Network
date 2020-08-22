import Foundation

/*******************************************************************************
 * JsonEnvelopeDecoder
 *
 * A JSON decoder where data are encapsulated into an enveloppe.
 *
 ******************************************************************************/

final class JsonEnvelopeDecoder<ResultType, EnvelopeDataItemType: Codable> {

  /// Tell if the `ResultType` is an array of `EnvelopeDataItemType` or an
  /// `EnvelopeDataItemType` object.
  ///
  /// - Returns: true if an array, false otherwise.
  static func isResultTypeArray() -> Bool {
    return ResultType.self is Array<EnvelopeDataItemType>.Type
  }

  static func decode(data: Data) throws -> ResultType {
    let envelope =
      try JSONDecoder().decode(MeloRequestModel<EnvelopeDataItemType>.self,
                               from: data)

    let isResultTypeArray =
      JsonEnvelopeDecoder<ResultType, EnvelopeDataItemType>.isResultTypeArray()

    let item: ResultType?
    if isResultTypeArray { item = envelope.data as? ResultType }
    else { item = envelope.data.first as? ResultType }

    guard let result = item else { throw NetworkError.invalidEnvelopeData }
    return result
  }

}

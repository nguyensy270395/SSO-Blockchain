// @generated
// This file was automatically generated and can be edited to
// implement advanced custom scalar functionality.
//
// Any changes to this file will not be overwritten by future
// code generation execution.

import Apollo
import Foundation

public extension MySchema {
    /// The `JSON` scalar type represents JSON values as specified by [ECMA-404](http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf).
    typealias JSON = String
}

extension Dictionary: JSONDecodable {
  public init(jsonValue value: JSONValue) throws {
    guard let dictionary = value as? Dictionary else {
      throw JSONDecodingError.couldNotConvert(value: value, to: Dictionary.self)
    }

    self = dictionary
  }
}

extension Attrs: OutputTypeConvertible {
    public static let _asOutputType: Selection.Field.OutputType = .nonNull(.scalar(Attrs.self as! any ScalarType.Type))
}

public struct Attrs : Codable {
    let classname : String?
    let dateOfBirth : String?
    let adress : String?
    let id : String?
    let fullName : String?

    enum CodingKeys: String, CodingKey {

        case classname = "Classname"
        case dateOfBirth = "Date of Birth"
        case adress = "Adress"
        case id = "Id"
        case fullName = "Full Name"
    }
}

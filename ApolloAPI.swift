//
//  ApolloAPI.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 12/04/2023.
//

import Foundation
import Apollo

extension MySchema {
    public enum CustomJSON: CustomScalarType, Hashable {
        case dictionary([String: AnyHashable])
        case array([AnyHashable])

        public init(_jsonValue value: JSONValue) throws {
            if let dict = value as? [String: AnyHashable] {
                self = .dictionary(dict)
            } else if let array = value as? [AnyHashable] {
                self = .array(array)
            } else {
                throw JSONDecodingError.couldNotConvert(value: value, to: CustomJSON.self)
            }
        }

        public var _jsonValue: JSONValue {
            switch self {
            case let .dictionary(json as AnyHashable),
                 let .array(json as AnyHashable):
                return json
            }
        }

        public var _dictionary: [String: AnyHashable] {
            switch self {
            case let .dictionary(json):
                return json
            case .array(_):
                return [:]
            }
        }

        public static func == (lhs: CustomJSON, rhs: CustomJSON) -> Bool {
            lhs._jsonValue == rhs._jsonValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(_jsonValue)
        }
    }
}

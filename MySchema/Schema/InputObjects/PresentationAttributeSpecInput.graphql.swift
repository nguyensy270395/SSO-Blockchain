// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension MySchema {
  struct PresentationAttributeSpecInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      credId: String,
      ruleId: String
    ) {
      __data = InputDict([
        "credId": credId,
        "ruleId": ruleId
      ])
    }

    public var credId: String {
      get { __data["credId"] }
      set { __data["credId"] = newValue }
    }

    public var ruleId: String {
      get { __data["ruleId"] }
      set { __data["ruleId"] = newValue }
    }
  }

}
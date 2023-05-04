// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension MySchema {
  struct PresentationInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      attributes: [PresentationAttributeSpecInput],
      proofExchangeId: String
    ) {
      __data = InputDict([
        "attributes": attributes,
        "proofExchangeId": proofExchangeId
      ])
    }

    public var attributes: [PresentationAttributeSpecInput] {
      get { __data["attributes"] }
      set { __data["attributes"] = newValue }
    }

    public var proofExchangeId: String {
      get { __data["proofExchangeId"] }
      set { __data["proofExchangeId"] = newValue }
    }
  }

}
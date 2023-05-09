// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension MySchema {
  class ProofExchangeReqReceivedSubscription: GraphQLSubscription {
    public static let operationName: String = "ProofExchangeReqReceived"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        subscription ProofExchangeReqReceived {
          proofExchangeReqReceived {
            __typename
            attributes {
              __typename
              credentials {
                __typename
                attrs
                cred_def_id
                referent
                schema_id
              }
              name
              ruleId
            }
            proofExchangeId
          }
        }
        """#
      ))

    public init() {}

    public struct Data: MySchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { MySchema.Objects.Subscription }
      public static var __selections: [Apollo.Selection] { [
        .field("proofExchangeReqReceived", ProofExchangeReqReceived.self),
      ] }

      public var proofExchangeReqReceived: ProofExchangeReqReceived { __data["proofExchangeReqReceived"] }

      /// ProofExchangeReqReceived
      ///
      /// Parent Type: `ProofExchangeReqReceivedEventObject`
      public struct ProofExchangeReqReceived: MySchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { MySchema.Objects.ProofExchangeReqReceivedEventObject }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("attributes", [Attribute].self),
          .field("proofExchangeId", String?.self),
        ] }

        public var attributes: [Attribute] { __data["attributes"] }
        public var proofExchangeId: String? { __data["proofExchangeId"] }

        /// ProofExchangeReqReceived.Attribute
        ///
        /// Parent Type: `ProofCredAttributeObject`
        public struct Attribute: MySchema.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { MySchema.Objects.ProofCredAttributeObject }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("credentials", [Credential].self),
            .field("name", String.self),
            .field("ruleId", String.self),
          ] }

          public var credentials: [Credential] { __data["credentials"] }
          public var name: String { __data["name"] }
          public var ruleId: String { __data["ruleId"] }

          /// ProofExchangeReqReceived.Attribute.Credential
          ///
          /// Parent Type: `IndyCredentialObject`
          public struct Credential: MySchema.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { MySchema.Objects.IndyCredentialObject }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("attrs", MySchema.CustomJSON?.self),
              .field("cred_def_id", String?.self),
              .field("referent", String?.self),
              .field("schema_id", String?.self),
            ] }

            public var attrs: MySchema.CustomJSON? { __data["attrs"] }
            public var cred_def_id: String? { __data["cred_def_id"] }
            /// credId - Credential identifier
            public var referent: String? { __data["referent"] }
            public var schema_id: String? { __data["schema_id"] }
          }
        }
      }
    }
  }

}

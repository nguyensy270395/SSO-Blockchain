// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension MySchema {
  class CredentialsQuery: GraphQLQuery {
    public static let operationName: String = "Credentials"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query Credentials {
          credentials {
            __typename
            attrs
            cred_def_id
            referent
            schema_id
          }
        }
        """#
      ))

    public init() {}

    public struct Data: MySchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { MySchema.Objects.Query }
      public static var __selections: [Apollo.Selection] { [
        .field("credentials", [Credential].self),
      ] }

      public var credentials: [Credential] { __data["credentials"] }

      /// Credential
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

// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension MySchema {
  class ParseDeeplinkQuery: GraphQLQuery {
    public static let operationName: String = "ParseDeeplink"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query ParseDeeplink($deeplink: String!) {
          parseDeeplink(deeplink: $deeplink) {
            __typename
            ... on DeeplinkProofPayloadObject {
              id
              type
            }
            ... on DeeplinkCredPayloadObject {
              credentialExchange {
                __typename
                attributes {
                  __typename
                  name
                  value
                }
                id
                indyFilter
                issuerConnectionId
                issuerWalletId
              }
              id
              type
            }
          }
        }
        """#
      ))

    public var deeplink: String

    public init(deeplink: String) {
      self.deeplink = deeplink
    }

    public var __variables: Variables? { ["deeplink": deeplink] }

    public struct Data: MySchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { MySchema.Objects.Query }
      public static var __selections: [Apollo.Selection] { [
        .field("parseDeeplink", ParseDeeplink.self, arguments: ["deeplink": .variable("deeplink")]),
      ] }

      public var parseDeeplink: ParseDeeplink { __data["parseDeeplink"] }

      /// ParseDeeplink
      ///
      /// Parent Type: `DeeplinkPayloadUnion`
      public struct ParseDeeplink: MySchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { MySchema.Unions.DeeplinkPayloadUnion }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .inlineFragment(AsDeeplinkProofPayloadObject.self),
          .inlineFragment(AsDeeplinkCredPayloadObject.self),
        ] }

        public var asDeeplinkProofPayloadObject: AsDeeplinkProofPayloadObject? { _asInlineFragment() }
        public var asDeeplinkCredPayloadObject: AsDeeplinkCredPayloadObject? { _asInlineFragment() }

        /// ParseDeeplink.AsDeeplinkProofPayloadObject
        ///
        /// Parent Type: `DeeplinkProofPayloadObject`
        public struct AsDeeplinkProofPayloadObject: MySchema.InlineFragment {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public typealias RootEntityType = ParseDeeplink
          public static var __parentType: Apollo.ParentType { MySchema.Objects.DeeplinkProofPayloadObject }
          public static var __selections: [Apollo.Selection] { [
            .field("id", String.self),
            .field("type", GraphQLEnum<MySchema.DeeplinkType>.self),
          ] }

          public var id: String { __data["id"] }
          public var type: GraphQLEnum<MySchema.DeeplinkType> { __data["type"] }
        }

        /// ParseDeeplink.AsDeeplinkCredPayloadObject
        ///
        /// Parent Type: `DeeplinkCredPayloadObject`
        public struct AsDeeplinkCredPayloadObject: MySchema.InlineFragment {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public typealias RootEntityType = ParseDeeplink
          public static var __parentType: Apollo.ParentType { MySchema.Objects.DeeplinkCredPayloadObject }
          public static var __selections: [Apollo.Selection] { [
            .field("credentialExchange", CredentialExchange.self),
            .field("id", String.self),
            .field("type", GraphQLEnum<MySchema.DeeplinkType>.self),
          ] }

          public var credentialExchange: CredentialExchange { __data["credentialExchange"] }
          public var id: String { __data["id"] }
          public var type: GraphQLEnum<MySchema.DeeplinkType> { __data["type"] }

          /// ParseDeeplink.AsDeeplinkCredPayloadObject.CredentialExchange
          ///
          /// Parent Type: `CredentialExchangeObject`
          public struct CredentialExchange: MySchema.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { MySchema.Objects.CredentialExchangeObject }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("attributes", [Attribute].self),
              .field("id", MySchema.ID.self),
              .field("indyFilter", MySchema.JSON.self),
              .field("issuerConnectionId", String?.self),
              .field("issuerWalletId", String.self),
            ] }

            public var attributes: [Attribute] { __data["attributes"] }
            public var id: MySchema.ID { __data["id"] }
            public var indyFilter: MySchema.JSON { __data["indyFilter"] }
            public var issuerConnectionId: String? { __data["issuerConnectionId"] }
            public var issuerWalletId: String { __data["issuerWalletId"] }

            /// ParseDeeplink.AsDeeplinkCredPayloadObject.CredentialExchange.Attribute
            ///
            /// Parent Type: `CredentialExchangeAttributeObject`
            public struct Attribute: MySchema.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: Apollo.ParentType { MySchema.Objects.CredentialExchangeAttributeObject }
              public static var __selections: [Apollo.Selection] { [
                .field("__typename", String.self),
                .field("name", String.self),
                .field("value", String.self),
              ] }

              public var name: String { __data["name"] }
              public var value: String { __data["value"] }
            }
          }
        }
      }
    }
  }

}
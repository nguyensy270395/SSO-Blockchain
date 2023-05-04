// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension MySchema {
  class RetrieveMessagePayloadQuery: GraphQLQuery {
    public static let operationName: String = "RetrieveMessagePayload"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query RetrieveMessagePayload($payloadId: String!) {
          retrieveMessagePayload(payloadId: $payloadId) {
            __typename
            id
            payload
          }
        }
        """#
      ))

    public var payloadId: String

    public init(payloadId: String) {
      self.payloadId = payloadId
    }

    public var __variables: Variables? { ["payloadId": payloadId] }

    public struct Data: MySchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { MySchema.Objects.Query }
      public static var __selections: [Apollo.Selection] { [
        .field("retrieveMessagePayload", RetrieveMessagePayload.self, arguments: ["payloadId": .variable("payloadId")]),
      ] }

      public var retrieveMessagePayload: RetrieveMessagePayload { __data["retrieveMessagePayload"] }

      /// RetrieveMessagePayload
      ///
      /// Parent Type: `MessagePayload`
      public struct RetrieveMessagePayload: MySchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { MySchema.Objects.MessagePayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("id", MySchema.ID.self),
          .field("payload", MySchema.JSON.self),
        ] }

        public var id: MySchema.ID { __data["id"] }
        public var payload: MySchema.JSON { __data["payload"] }
      }
    }
  }

}
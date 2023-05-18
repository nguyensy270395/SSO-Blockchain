// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension MySchema {
  class AddDeviceMutation: GraphQLMutation {
    public static let operationName: String = "AddDevice"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation AddDevice($token: String!) {
          addDevice(token: $token) {
            __typename
            token
            walletId
          }
        }
        """#
      ))

    public var token: String

    public init(token: String) {
      self.token = token
    }

    public var __variables: Variables? { ["token": token] }

    public struct Data: MySchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { MySchema.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("addDevice", AddDevice.self, arguments: ["token": .variable("token")]),
      ] }

      public var addDevice: AddDevice { __data["addDevice"] }

      /// AddDevice
      ///
      /// Parent Type: `Device`
      public struct AddDevice: MySchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { MySchema.Objects.Device }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("token", String.self),
          .field("walletId", String.self),
        ] }

        public var token: String { __data["token"] }
        public var walletId: String { __data["walletId"] }
      }
    }
  }

}
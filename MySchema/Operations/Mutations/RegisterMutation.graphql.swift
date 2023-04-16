// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension MySchema {
  class RegisterMutation: GraphQLMutation {
    public static let operationName: String = "Register"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation Register($data: RegisterInput!) {
          register(data: $data) {
            __typename
            accessToken
            wallet {
              __typename
              email
              id
              role
            }
          }
        }
        """#
      ))

    public var data: RegisterInput

    public init(data: RegisterInput) {
      self.data = data
    }

    public var __variables: Variables? { ["data": data] }

    public struct Data: MySchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { MySchema.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("register", Register.self, arguments: ["data": .variable("data")]),
      ] }

      public var register: Register { __data["register"] }

      /// Register
      ///
      /// Parent Type: `AuthorizableObject`
      public struct Register: MySchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { MySchema.Objects.AuthorizableObject }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("accessToken", String.self),
          .field("wallet", Wallet.self),
        ] }

        public var accessToken: String { __data["accessToken"] }
        public var wallet: Wallet { __data["wallet"] }

        /// Register.Wallet
        ///
        /// Parent Type: `Wallet`
        public struct Wallet: MySchema.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { MySchema.Objects.Wallet }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("email", String.self),
            .field("id", MySchema.ID.self),
            .field("role", GraphQLEnum<MySchema.WalletRole>.self),
          ] }

          public var email: String { __data["email"] }
          public var id: MySchema.ID { __data["id"] }
          public var role: GraphQLEnum<MySchema.WalletRole> { __data["role"] }
        }
      }
    }
  }

}
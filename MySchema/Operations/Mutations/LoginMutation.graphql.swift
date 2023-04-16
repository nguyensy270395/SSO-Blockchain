// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension MySchema {
  class LoginMutation: GraphQLMutation {
    public static let operationName: String = "Login"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation Login($data: LoginInput!) {
          login(data: $data) {
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

    public var data: LoginInput

    public init(data: LoginInput) {
      self.data = data
    }

    public var __variables: Variables? { ["data": data] }

    public struct Data: MySchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { MySchema.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("login", Login.self, arguments: ["data": .variable("data")]),
      ] }

      public var login: Login { __data["login"] }

      /// Login
      ///
      /// Parent Type: `AuthorizableObject`
      public struct Login: MySchema.SelectionSet {
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

        /// Login.Wallet
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
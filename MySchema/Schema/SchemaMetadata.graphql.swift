// @generated
// This file was automatically generated and should not be edited.

import Apollo

public protocol MySchema_SelectionSet: Apollo.SelectionSet & Apollo.RootSelectionSet
where Schema == MySchema.SchemaMetadata {}

public protocol MySchema_InlineFragment: Apollo.SelectionSet & Apollo.InlineFragment
where Schema == MySchema.SchemaMetadata {}

public protocol MySchema_MutableSelectionSet: Apollo.MutableRootSelectionSet
where Schema == MySchema.SchemaMetadata {}

public protocol MySchema_MutableInlineFragment: Apollo.MutableSelectionSet & Apollo.InlineFragment
where Schema == MySchema.SchemaMetadata {}

public extension MySchema {
  typealias ID = String

  typealias SelectionSet = MySchema_SelectionSet

  typealias InlineFragment = MySchema_InlineFragment

  typealias MutableSelectionSet = MySchema_MutableSelectionSet

  typealias MutableInlineFragment = MySchema_MutableInlineFragment

  enum SchemaMetadata: Apollo.SchemaMetadata {
    public static let configuration: Apollo.SchemaConfiguration.Type = SchemaConfiguration.self

    public static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "Mutation": return MySchema.Objects.Mutation
      case "AuthorizableObject": return MySchema.Objects.AuthorizableObject
      case "Wallet": return MySchema.Objects.Wallet
      case "Query": return MySchema.Objects.Query
      case "IndyCredentialObject": return MySchema.Objects.IndyCredentialObject
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}
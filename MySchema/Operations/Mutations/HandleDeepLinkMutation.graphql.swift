// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension MySchema {
  class HandleDeepLinkMutation: GraphQLMutation {
    public static let operationName: String = "HandleDeepLink"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation HandleDeepLink($url: String!) {
          handleDeepLink(url: $url)
        }
        """#
      ))

    public var url: String

    public init(url: String) {
      self.url = url
    }

    public var __variables: Variables? { ["url": url] }

    public struct Data: MySchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { MySchema.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("handleDeepLink", Bool.self, arguments: ["url": .variable("url")]),
      ] }

      public var handleDeepLink: Bool { __data["handleDeepLink"] }
    }
  }

}
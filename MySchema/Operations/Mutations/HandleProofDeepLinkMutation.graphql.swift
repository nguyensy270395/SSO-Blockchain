// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension MySchema {
  class HandleProofDeepLinkMutation: GraphQLMutation {
    public static let operationName: String = "HandleProofDeepLink"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation HandleProofDeepLink($url: String!) {
          handleProofDeepLink(url: $url)
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
        .field("handleProofDeepLink", Bool.self, arguments: ["url": .variable("url")]),
      ] }

      public var handleProofDeepLink: Bool { __data["handleProofDeepLink"] }
    }
  }

}
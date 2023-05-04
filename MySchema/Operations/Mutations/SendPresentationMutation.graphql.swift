// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension MySchema {
  class SendPresentationMutation: GraphQLMutation {
    public static let operationName: String = "SendPresentation"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation SendPresentation($data: PresentationInput!) {
          sendPresentation(data: $data)
        }
        """#
      ))

    public var data: PresentationInput

    public init(data: PresentationInput) {
      self.data = data
    }

    public var __variables: Variables? { ["data": data] }

    public struct Data: MySchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { MySchema.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("sendPresentation", Bool.self, arguments: ["data": .variable("data")]),
      ] }

      public var sendPresentation: Bool { __data["sendPresentation"] }
    }
  }

}
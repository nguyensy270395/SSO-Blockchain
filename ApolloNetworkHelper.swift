//
//  ApolloNetworkHelper.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 12/04/2023.
//

import Foundation

class ApolloNetwork {
    static let shared = ApolloNetwork()
    lazy var apollo: ApolloClient = {
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let authPayloads = ["Authorization": token]
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = authPayloads
        let client = URLSessionClient(sessionConfiguration: configuration)
        let provider = NetworkInterceptorProvider(client: client, shouldInvalidateClientOnDeinit: true , store: store)
        let url = URL(string: "https://kmaauth.tek4.vn/graphql")!
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
        return ApolloClient(networkTransport: requestChainTransport, store: store)
    }()
}

class NetworkInterceptorProvider: DefaultInterceptorProvider {
    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
        return super.interceptors(for: operation)
    }
}

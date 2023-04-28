//
//  IdentityViewModel.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 27/04/2023.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class IdentityViewModel: BaseViewModel, BaseViewModelProtocol {

    struct Input {
        let getData: Observable<Void>
    }

    struct Output {

    }

    func transfrom(from input: Input) -> Output {
        input.getData.subscribe(onNext: {_ in
            ApolloNetwork.shared.apollo.fetch(query: MySchema.CredentialsQuery()) {result in
                switch result {
                case .success(let queryResult):
                    if let error = queryResult.errors {
                        let message = error.map{ $0.localizedDescription }
                        print("Error: \(message.first)")
                        return
                    }
                    if let data = queryResult.data?.credentials{
                        print("Success: \(data)")
                    }
                case .failure(let error):
                    print("Fail Query: \(error)")
                }
            }
        }).disposed(by: disposeBag)
        
        return Output()
    }


}

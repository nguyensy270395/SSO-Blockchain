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

    var credentialData: [MySchema.CredentialsQuery.Data.Credential] = []

    struct Input {
        let getData: Observable<Void>
    }

    struct Output {
        let updateData: Driver<Bool>
    }

    func transfrom(from input: Input) -> Output {
        let updateData = PublishSubject<Bool>()
        input.getData.subscribe(onNext: {_ in
            ApolloNetwork.shared.apollo.fetch(query: MySchema.CredentialsQuery()) {[weak self] result in
                switch result {
                case .success(let queryResult):
                    if let error = queryResult.errors {
                        let message = error.map{ $0.localizedDescription }
                        updateData.onNext(false)
                        print("Error: \(message.first)")
                        return
                    }
                    if let data = queryResult.data?.credentials{
                        self?.credentialData = data
                        updateData.onNext(true)
                    }
                case .failure(let error):
                    updateData.onNext(false)
                    print("Fail Query: \(error)")
                }
            }
        }).disposed(by: disposeBag)
        
        return Output(updateData: updateData.asDriver(onErrorJustReturn: false))
    }


}

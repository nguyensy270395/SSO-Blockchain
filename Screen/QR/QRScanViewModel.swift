//
//  QRScanViewModel.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 06/05/2023.
//

import Foundation
import RxCocoa
import RxRelay
import RxSwift

class QRScanViewModel: BaseViewModel, BaseViewModelProtocol {

    struct Input {
        let qrLink: Observable<String>
    }

    struct Output {
        let checkDone: Driver<Bool>
    }

    func transfrom(from input: Input) -> Output {
        var output = PublishSubject<Bool>()

        ApolloNetwork.shared.apollo.subscribe(subscription: MySchema.ProofExchangeReqReceivedSubscription()) {[weak self] result in
            switch result {
            case .success(let queryResult):

                if let error = queryResult.errors {
                    let message = error.map{ $0.localizedDescription }
                    print("Error: \(message.first)")
                    return
                }

                if let data = queryResult.data?.proofExchangeReqReceived{
                    print(data)
                }

            case .failure(let error):
                print("Fail Query: \(error)")
            }
        }
        
        input.qrLink.subscribe(onNext: {[weak self] link in
            guard let self = self else { return }



            let checkParse = PublishSubject<Bool>()
            let checkHandle = PublishSubject<Bool>()
            ApolloNetwork.shared.apollo.fetch(query: MySchema.ParseDeeplinkQuery(deeplink: link)) {[weak self] result in
                switch result {
                case .success(let queryResult):
                    if let error = queryResult.errors {
                        let message = error.map{ $0.localizedDescription }
                        checkParse.onNext(false)
                        print("Error: \(message.first)")
                        return
                    }
                    if let data = queryResult.data?.parseDeeplink{
                        checkParse.onNext(true)
                    }
                case .failure(let error):
                    checkParse.onNext(false)
                    print("Fail Query: \(error)")
                }
            }
            ApolloNetwork.shared.apollo.perform(mutation: MySchema.HandleProofDeepLinkMutation(url: link)) {[weak self] result in
                switch result {
                case .success(let queryResult):
                    if let error = queryResult.errors {
                        let message = error.map{ $0.localizedDescription }
                        checkHandle.onNext(false)
                        print("Error: \(message.first)")
                        return
                    }
                    if let data = queryResult.data?.handleProofDeepLink{
                        checkHandle.onNext(true)
                    }
                case .failure(let error):
                    checkHandle.onNext(false)
                    print("Fail Query: \(error)")
                }
            }

            let obser = Observable.zip(checkParse.asObserver(), checkHandle.asObserver())
            obser.subscribe(onNext: {(checkParse, checkHandle) in
                output.onNext(checkParse && checkHandle)
            }).disposed(by: self.disposeBag)
//            ApolloNetwork.shared.apollo.fetch(query: MySchema.ParseDeeplinkQuery(deeplink: link)) {[weak self] result in
//                switch result {
//                case .success(let queryResult):
//                    if let error = queryResult.errors {
//                        let message = error.map{ $0.localizedDescription }
//                        checkParse.onNext(false)
//                        print("Error: \(message.first)")
//                        return
//                    }
//                    if let data = queryResult.data?.parseDeeplink{
//                        checkParse.onNext(true)
//                    }
//                case .failure(let error):
//                    checkParse.onNext(false)
//                    print("Fail Query: \(error)")
//                }
//            }
        }).disposed(by: disposeBag)
        return Output(checkDone: output.asDriver(onErrorJustReturn: false))
    }


}

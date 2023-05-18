//
//  ProofRequestViewModel.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 06/05/2023.
//

import Foundation
import RxCocoa
import RxRelay
import RxSwift
import LocalAuthentication

class ProofRequestViewModel: BaseViewModel, BaseViewModelProtocol {

    var attribute = MySchema.PresentationAttributeSpecInput.init(credId: "", ruleId: "")
    var data: MySchema.ParseDeeplinkQuery.Data.ParseDeeplink
    var callAPI = PublishSubject<Void>()
    var dataAttribute: [(String, AnyHashable)] = [("Full Name", "Nguyen Thanh Sy"), ("ID", "0847398"), ("Date of Birth","22/12/2002"), ("Sex","Male"), ("Place of Birth", "Ha Noi")]
    var numberCell: Int {
        (2 + dataAttribute.count)
    }

    init(data: MySchema.ParseDeeplinkQuery.Data.ParseDeeplink) {
        self.data = data
    }

    func checkLogin() -> Observable<Bool> {
        let context = LAContext()
        let obser = PublishSubject<Bool>()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        obser.onNext(true)
                    } else {
                        obser.onNext(false)
                    }
                }
            }
        } else {
            obser.onNext(false)
        }
        return obser.asObserver()
    }

    func transfrom(from input: Input) -> Output {
        let checkDone = PublishSubject<Bool>()
        let data = MySchema.PresentationInput(attributes: [attribute], proofExchangeId: data.asDeeplinkProofPayloadObject?.id ?? "")
        input.actionShare.subscribe(onNext: {[weak self] _ in
            ApolloNetwork.shared.apollo.perform(mutation: MySchema.SendPresentationMutation(data: data)) {result in
                switch result {
                case .success(let queryResult):
                    if let error = queryResult.errors {
                        let message = error.map{ $0.localizedDescription }
                        checkDone.onNext(false)
                        print("Error: \(message.first)")
                        return
                    }
                    if let data = queryResult.data?.sendPresentation{
                        checkDone.onNext(data)
                    }
                case .failure(let error):
                    checkDone.onNext(false)
                    print("Fail Query: \(error)")
                }
            }
        }).disposed(by: disposeBag)
        return Output(checkDone: checkDone.asDriver(onErrorJustReturn: false))
    }

    struct Input {
        let actionShare: Observable<Void>
    }

    struct Output {
        let checkDone: Driver<Bool>
    }
}

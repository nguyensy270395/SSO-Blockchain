//
//  ApplicationViewModel.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 14/05/2023.
//

import Foundation
import RxCocoa
import RxRelay
import RxSwift
import LocalAuthentication

class ApplicationViewModel: BaseViewModel {

    func addDevice(){
        if let fcmKey = UserDefaults.standard.string(forKey: "fcmKey"), let token = UserDefaults.standard.string(forKey: "token") {
            ApolloNetwork.shared.apollo.perform(mutation: MySchema.AddDeviceMutation(token: fcmKey)) {result in
                switch result {
                case .success(let queryResult):
                    if let error = queryResult.errors {
                        let message = error.map{ $0.localizedDescription }
                        print("Error: \(message.first)")

                        return
                    }
                    if let data = queryResult.data{
                        print("Add device done.....")

                    }
                case .failure(let error):
                    print("Fail Query: \(error)")
                  
                }
            }
        }
    }
}

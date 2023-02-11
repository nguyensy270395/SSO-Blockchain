import RxAlamofire
import Alamofire
import RxSwift
import RxCocoa
import UIKit
import Reachability
import RxReachability

// swiftlint:disable vertical_parameter_alignment
struct ApiRequest {
    
    static var NUMBER_OF_RETRY = 4
    
    static func request<T: Codable>(_ input: ApiInput,
                                   shouldHandleRetry: Bool = true,
                                   shouldAuthorize: Bool = true,
                                   returnError: Bool = false,
                                   shouldCheckServerError: Bool = true) -> Observable<T> {
//        let url = try? input.url.asURL().absoluteString.removingPercentEncoding
        return RxAlamofire.request(input.method,
                                   input.url,
                                   parameters: input.params,
                                   encoding: input.encoding,
                                   headers: input.headers,
                                   interceptor: shouldAuthorize ? NetworkManager() : nil)
        .validate(statusCode: 0..<300)
        .responseJSON()
        .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
        .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
        .flatMap({ response -> Observable<T> in
            if let data = response.data {
                do {
                    let value = try JSONDecoder().decode(T.self, from: data)
                    return .just(value)
                } catch let e {
                    print(e.localizedDescription)
                    return .error(APIErrors.systemError)
                }
            } else {
                return .error(APIErrors.systemError)
            }
        })
        .observe(on: MainScheduler.asyncInstance)
        .catch({ error -> Observable<T> in
            let httpCode = error.asAFError?.responseCode ?? 0
            let needRetry = (NetworkReachabilityManager()?.isReachable == false
                             || httpCode == ErrorCode.serverError.rawValue) && shouldHandleRetry && shouldCheckServerError
            if needRetry {
                return .empty()
//                return ApiRequest.showServerError(code: httpCode)
//                    .flatMap({ shouldRetry -> Observable<T> in
//                        if shouldRetry {
//                            return ApiRequest.request(input, shouldHandleRetry: shouldHandleRetry, shouldAuthorize: shouldAuthorize, returnError: returnError, shouldCheckServerError: shouldCheckServerError)
//                        } else {
//                            return returnError ? Observable.error(error) : Observable.empty()
//                        }
//                    })
            } else {
                return Observable.error(error)
            }
        })
    }
}

class NetworkManager: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        let token = AppData.token
        let bearerToken = "Bearer \(token)"
        request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        print("\nadapted; token added to the header field is: \(bearerToken)\n")
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        
        guard request.retryCount < ApiRequest.NUMBER_OF_RETRY else {
            completion(.doNotRetry)
            if statusCode == ErrorCode.unauthorize.rawValue {
//                DBKeychainAccess.logout()
            }
            return
        }
        
        print("retry statusCode....\(statusCode)")
        switch statusCode {
        case 200...299:
            completion(.doNotRetry)
        case ErrorCode.unauthorize.rawValue:
            refreshToken { isSuccess in isSuccess ? completion(.retry) : completion(.doNotRetry) }
        default:
            completion(.retry)
        }
    }
    
    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        completion(true)
//        let params = [
//            "grant_type": "refresh_token",
//            "refresh_token": Settings.shared.refreshToken ?? ""
//        ]
//        AF.request(ApiRouter.by(url: .LOGIN_MAIL_PASS), method: .post,
//                   parameters: params, encoding: JSONEncoding.default)
//        .responseDecodable(of: LoginModel.self) { response in
//            if let value = response.value, let token = value.access_token {
//                DBKeychainAccess.setSessionToken(token: token)
//                Settings.shared.refreshToken = value.refresh_token
//
//                //HOAVM todo login
//                HyperCheckupSession.accessToken = value.access_token ?? ""
//                HyperCheckupSession.userId = "\(HyperCheckupSession.accessToken?.decodeJwt()["id"] as? Int ?? 0)"
//                HyperCheckupSession.userId = "1006"
//                HyperCheckupSession.token_type = value.token_type
//
//                completion(true)
//            } else {
//                completion(false)
//                DBKeychainAccess.logout()
//            }
//        }
    }
    
}
// swiftlint:enable vertical_parameter_alignment

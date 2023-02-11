import Alamofire

public enum APIErrors: Error {
    case networkError
    case noResponse
    case responseIsInvalid
    case noStatus
    case notFound
    case unauthorized
    case systemError
    case apiErrorValidate(code:Int, errors:[String:String])
    case apiErrorString(code:Int, message:String)
    
    var localizedDescription:String{
        switch self {
        case .networkError:
            return "ネットワークが失われました。"
        case .systemError:
            return "システムエラー。"
        default:
            return ""
        }
    }
    
}

enum ErrorCode: Int {
    case unauthorize = 401
    case serverError = 500
    case success = 200
}

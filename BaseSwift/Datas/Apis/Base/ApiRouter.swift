import Foundation
import RxAlamofire
import Alamofire

enum API {
//    case GET_USER_INFO(id: Int)
//    case GET_SHOP_INFO(id: Int)
//    case GET_COMMONS
//    case INIT
//    case GET_SHOP_MENU(id: Int)
//    case GET_SHOP_PHOTO(id: Int)
//    case CHANGE_CHARACTER_COLOR
//    case ME
//    case DAILY_GIFT_HISTORY(id: Int)
//    case GET_RANK
//    case OWNED_CHARACTER
//    case CHANGE_CHARACTER
//    case BOOKING(id: Int)
    var path: String {
        switch self {
//        case .GET_USER_INFO(let id):
//            return "\(id)"
//        case .GET_SHOP_INFO(let id):
//            return "shop/\(id)"
//        case .GET_COMMONS:
//            return "common"
//        case .INIT:
//            return "init"
//        case .GET_SHOP_MENU(let id):
//            return "shop/\(id)/menu"
//        case .GET_SHOP_PHOTO(let id):
//            return "shop/\(id)/photo"
//        case .CHANGE_CHARACTER_COLOR:
//            return "change_character_color"
//        case .ME:
//            return "me"
//        case .DAILY_GIFT_HISTORY(let id):
//            return "daily_gift/\(id)"
//        case .GET_RANK:
//            return "minigame/rank"
//        case .OWNED_CHARACTER:
//            return "owned_character"
//        case .CHANGE_CHARACTER:
//            return "change_character"
//        case .BOOKING(let id):
//            return "booking/\(id)"
        }
        
    }
    
    var baseUrl: String {
        switch self {
        default: return AppConfigs.baseUrl
        }
    }
}

struct ApiRouter: URLConvertible {
    
    private var api: API
    
    init(api: API) {
        self.api = api
    }
    
    var path: String {
        return api.path
    }
    
    func asURL() throws -> URL {
        var url = try api.baseUrl.asURL()
        url.appendPathComponent(path)
        print("url:\(url)")
        return url
    }
}

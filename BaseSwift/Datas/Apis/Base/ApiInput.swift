import RxAlamofire
import Alamofire
extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
struct ApiInput {
    var method: HTTPMethod = .get
    var url: URLConvertible = ""
    var params: Parameters?
    var encoding: URLEncoding = .default
    var headers: HTTPHeaders = [
        "Accept": "application/json"
    ]
    
    init(method: HTTPMethod, url:ApiRouter, params:Parameters? = nil, headers:[String:String]? = nil) {
        self.method = method
        self.url = url
        self.params = params
        if let header = headers {
            for (name, value) in header {
                self.headers.add(name: name, value: value)
            }
        }
//        let token = AppData.token
//        print(token)
//        if !token.isEmpty {
//            self.headers.add(.authorization(bearerToken: token))
//        }
        
//        let dictionary = Bundle.main.infoDictionary
//        guard let version = dictionary?["CFBundleShortVersionString"] as? String else{
//            return
//        }
//        self.headers.add(name: "version", value: version)
    }
}

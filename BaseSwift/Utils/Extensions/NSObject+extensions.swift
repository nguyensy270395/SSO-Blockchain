import Foundation
import UIKit
import CoreLocation
import Contacts

extension NSObject {
    var className: String {
        return NSStringFromClass(type(of: self))
    }
    class var className: String {
        return String(describing: self)
    }
    
    class func readJsonToObject<T>(jsonFileName:String, objectType:T.Type ) -> [T] where T : Codable{
        if let path = Bundle.main.path(forResource: jsonFileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let objects = try decoder.decode([T].self, from: data)
                return objects
            } catch {
                print(error)
                // handle error
            }
        }
        return []
    }
}

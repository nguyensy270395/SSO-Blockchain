import KeychainAccess

//class LGKeychainAccess:NSObject {
//
//    static let KEY_SAVED_USERNAME = "KEY_SAVED_USERNAME"
//    static let KEY_SAVED_PASSWORD = "KEY_SAVED_PASSWORD"
//    static let KEY_DEVICE_UUID = "KEY_DEVICE_UUID" //do not delete it
//    static let KEY_SESSION_TOKEN = "KEY_SESSION_TOKEN"
//    static var KEY_USER_ID = "KEY_USER_ID"
//    static let keychain = Keychain(service: Environment.bundleID)
//    class func logout(){
//
//    }
//
//    class func withdraw(){
//        self.clearUserNameAndPassword()
//        self.logout()
//    }
//
//
//    class func set(value:String?,key:String){
//        keychain[key] = value
//    }
//    class func get(key:String)->String{
//        let value = keychain[key]
//        return (value != nil) ? (value!) : ""
//    }
//
//    // MARK: Device UUID
//    class func getDeviceUUID()->String{
//        var uuid = self.get(key: LGKeychainAccess.KEY_DEVICE_UUID)
//        if uuid.isEmpty{
//            uuid = UIDevice.current.identifierForVendor!.uuidString
//            self.set(value: uuid, key: LGKeychainAccess.KEY_DEVICE_UUID)
//        }
//        return uuid
//    }
//    //remember login
//    class func setUserNameAndPassword(username:String,password:String){
//        self.set(value: username, key: LGKeychainAccess.KEY_SAVED_USERNAME)
//        self.set(value: password, key: LGKeychainAccess.KEY_SAVED_PASSWORD)
//    }
//    class func getUserNameAndPassword()->(String,String){
//        return (self.get(key: LGKeychainAccess.KEY_SAVED_USERNAME),self.get(key: LGKeychainAccess.KEY_SAVED_PASSWORD))
//    }
//    class func clearUserNameAndPassword(){
//        self.set(value: nil, key: LGKeychainAccess.KEY_SAVED_USERNAME)
//        self.set(value: nil, key: LGKeychainAccess.KEY_SAVED_PASSWORD)
//    }
//
//    //session token
//    class func setSessionToken(token:String){
//        self.set(value: token, key: LGKeychainAccess.KEY_SESSION_TOKEN)
//    }
//    class func getSessionToken()->String{
//       return self.get(key: LGKeychainAccess.KEY_SESSION_TOKEN)
//    }
//
//    class func setUserId(value:String){
//        self.set(value: value, key: LGKeychainAccess.KEY_USER_ID)
//    }
//    class func getUserId()->String{
//       return self.get(key: LGKeychainAccess.KEY_USER_ID)
//    }
//
//    class func isLogined()->Bool{
//        return !self.getSessionToken().isEmpty
//    }
//}

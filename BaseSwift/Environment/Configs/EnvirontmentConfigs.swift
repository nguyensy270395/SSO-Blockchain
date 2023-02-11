import Foundation

enum ENV: String {
    case DEBUG
    case STAGGING
    case RELEASE
}

struct AppConfigs {
    static let env: ENV = ENV(rawValue: infoForKey("ENV")) ?? .DEBUG
    static let baseUrl: String = infoForKey("BASE_URL")
}

private class KeyName {}

extension AppConfigs {
    static func infoForKey(_ key: String) -> String {
        return Bundle(for: KeyName.self).object(forInfoDictionaryKey: key) as? String ?? ""
    }
}

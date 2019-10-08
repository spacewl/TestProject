import Foundation

protocol ServerConstatns {
    static var domenURL: String { get }
    static var version: String { get }
}

struct ServerConstants {
    static var currentServer: ServerConstatns.Type { return StagingServer.self }
    
    static let baseURL = "\(currentServer.domenURL)\(currentServer.version)"
    
    struct ProductionServer: ServerConstatns {
        static let domenURL = "https://samples.openweathermap.org"
        static let version = "/data/2.5"
    }
    
    struct StagingServer: ServerConstatns {
        static let domenURL = "https://samples.openweathermap.org"
        static let version = "/data/2.5"
    }
}

enum HTTPHeaderField: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case acceptLanguage = "Accept-language"
    case version = "version"
}

enum HTTPHeaderValue {
    static let json   = "application/json"
    static let multipart = "multipart/form-data"
    static let language  = Bundle.main.preferredLocalizations.first! as String
}

enum StatusCode {
    enum errorCode: Int {
        init(_ fromRawValue: Int?){
            guard let code = fromRawValue else {
                self = .undefined
                return
            }
            self = errorCode(rawValue: code) ?? .undefined
        }
        case undefined = 2000
        case OK = 200
    }
}

enum ReqeustsKeys {
    static let queary   = "q"
    static let appId = "appid"
    static let weatherAppId = "b6907d289e10d714a6e88b30761fae22"
}

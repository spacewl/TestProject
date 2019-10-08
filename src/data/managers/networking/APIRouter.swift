
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    // City
    case getAllCities
    
    // Weather
    case getWeatherByCityName(_ name: String)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getAllCities:
            return .post
        case .getWeatherByCityName:
            return .get
//        case
//            return .patch
//        case
//            return .put
//        case
//            return .delete
        }
    }
    
    // MARK: - AccessToken required
    var needAccessToken: Bool {
        switch self {
        case .getWeatherByCityName:
            return false
        default:
            return true
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .getAllCities:
            return ""
        case .getWeatherByCityName:
            return "/weather"
        }
    }
    
    // MARK: - Headers
    var headers: [String:String] {
        let headers = [HTTPHeaderField.acceptLanguage.rawValue : HTTPHeaderValue.language]
        
        return headers
    }
    
    // MARK: - Parameters
    var parameters: Encodable? {
        switch self {
        case .getWeatherByCityName(let name):
            return [ReqeustsKeys.queary: name, ReqeustsKeys.appId: ReqeustsKeys.weatherAppId]
            
        default:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let baseUrlStr = ServerConstants.baseURL
        var urlRequest: URLRequest!
        
        if method == .get  || method == .delete {
            urlRequest = ParametersQueryConfigurator.configureRequrst(baseUrlStr: baseUrlStr, path: path, parameters: parameters)
        } else if method == .post || method == .put  || method == .patch {
            urlRequest = try ParametersBodyConfigurator.configureRequest(baseUrlStr: baseUrlStr, path: path, parameters: parameters)
        } else {
            fatalError()
        }
        
        urlRequest.httpMethod = method.rawValue
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
}

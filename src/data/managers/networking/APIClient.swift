import Alamofire
import PromiseKit

class APIClient {
    
    // MARK: - City
    
    static func getAllCities() -> [CityModel] {
        // TODO: replace when backend will be available
        return [ CityModel.init("London") ]
    }
    
    // MARK: - Weather
    
    static func getWeatherByCityName(_ name: String) -> Promise<WeatherModel> {
        return performRequest(route: APIRouter.getWeatherByCityName(name))
    }
}

// MARK: - Response Structures

struct AppResponse<T:Codable>: Codable {
    var data: T
    var status: String?
    var error: String?
}

extension APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder()) -> Promise<T> {
            let promise = Alamofire.request(route)
            .responseJSON(completionHandler: { (response) in
                print(response)
            })
            .responseDecodable(T.self)
        
            return promise
    }
}

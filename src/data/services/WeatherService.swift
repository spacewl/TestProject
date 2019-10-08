
import UIKit
import PromiseKit

class WeatherService: NSObject {
    public func getWeatherByCityName(_ name: String) -> Promise<WeatherModel> {
        return Promise { seal in
            APIClient.getWeatherByCityName(name)
                .done({ (weather) in
                    seal.fulfill(weather)
                })
                .catch({ (error) in
                    seal.reject(error)
                })
        }
    }
}

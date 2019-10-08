
import UIKit

class WeatherModel: Decodable {
    public let base: String
    public let id: Int
    public let cityName: String
    public let wind: WeatherWindModel
    public let weather: [WeatherInfoModel]
    public let main: WeatherMaindModel
    
    enum CodingKeys: String, CodingKey {
        case base
        case id
        case cityName = "name"
        case wind
        case weather
        case main
    }
}

struct WeatherMaindModel: Decodable {
    public let humidity: Int
    public let pressure: Int
    public let temp: Double
    public let tempMax: Double
    public let tempMin: Double
    
    enum CodingKeys: String, CodingKey {
        case humidity
        case pressure
        case temp
        case tempMax = "temp_max"
        case tempMin = "temp_min"
    }
}

struct WeatherInfoModel: Decodable {
    public let description: String
    public let icon: String
    public let id: Int
    public let main: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case icon
        case id
        case main
    }
}

struct WeatherWindModel: Decodable {
    public let deg: Int
    public let speed: Double
    
    enum CodingKeys: String, CodingKey {
        case deg
        case speed
    }
}

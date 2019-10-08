
import UIKit
import PromiseKit

class CityService: NSObject {
    
    var cities: [CityModel] = []
    
    override init() {
        
    }
    
    // TODO: replace when backend will be available
    public func getAllCities() -> [CityModel] {
        self.cities = APIClient.getAllCities()
        
        return self.cities
    }
}

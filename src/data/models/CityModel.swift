
import UIKit

class CityModel: Decodable {
    public let id: Int
    public let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(_ name: String) {
        self.id = 0
        self.name = name
    }
}

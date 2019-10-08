
import UIKit

class CitiesListTableViewCell: BaseTableViewCell {

    @IBOutlet private weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cityNameLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
    }

    func setupModel(_ model: CityModel) {
        self.cityNameLabel.text = model.name
    }
}


import UIKit

class CityWeatherViewController: BaseViewController {

    private var model: WeatherModel!
    
    @IBOutlet private weak var cityInformationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.model.cityName
    }
    
    override func updateUi() {
        self.cityInformationLabel.attributedText = self.weatherDescriptionText()
    }
    
    // MARK: - Actions
    
    func setupModel(_ model: WeatherModel) {
        self.model = model
    }
    
    // MARK: - Helpers
    
    private func weatherDescriptionText() -> NSAttributedString {
        let windText = "Wind"
        let tempText = "Temperature"
        let pressureText = "Pressure"
        
        let speed = String(self.model.wind.speed)
        let temp = String(self.model.main.temp)
        let pressure = String(self.model.main.pressure)
        
        let fullText = "\(windText) - \(speed)\n\(tempText) - \(temp)\n\(pressureText) - \(pressure)\n"
        
        let text = NSMutableAttributedString.init(string: fullText,
                                                  attributes: [.font : UIFont.systemFont(ofSize: 15.0),
                                                               .foregroundColor : UIColor.black])
        
        self.updateAttributeText(text, speed, fullText)
        self.updateAttributeText(text, temp, fullText)
        self.updateAttributeText(text, pressure, fullText)
        
        return text
    }
    
    private func updateAttributeText(_ attributeString: NSMutableAttributedString, _ value: String, _ fullText: String) {
        if let range = fullText.range(of: value) {
            let nsRange = NSRange(range, in: fullText)
            attributeString.setAttributes([.font : UIFont.boldSystemFont(ofSize: 15.0)], range: nsRange)
        }
    }
}


import UIKit

class CitiesListViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var cityService = CityService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cities list"

        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getData()
    }

    // MARK: - Actions
    
    private func getData() {
        // TODO: replace when backend will be available
        _ = ActivityIndicatorView.showActivity()
        
        _ = self.cityService.getAllCities()
        self.tableView.reloadData()
        
        ActivityIndicatorView.hideAllActivity()
    }
    
    private func openCityPreview(_ model: CityModel) {
        _ = ActivityIndicatorView.showActivity()
        
        WeatherService.init().getWeatherByCityName(model.name)
        .done { (weather) in
                
            ActivityIndicatorView.hideAllActivity()
            guard let vc = CityWeatherViewController.initFromNib() as? CityWeatherViewController else { return }
            vc.setupModel(weather)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
            .catch { (error) in
                ActivityIndicatorView.hideAllActivity()
                self.alertShowMessage(error.localizedDescription)
        }
    }

    // MARK: - Helpers
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CitiesListTableViewCell.nib(), forCellReuseIdentifier: CitiesListTableViewCell.identifier())
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
    }
}

extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityService.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CitiesListTableViewCell.identifier()) as? CitiesListTableViewCell
        cell?.setupModel(self.cityService.cities[indexPath.row])
        
        return cell ?? UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openCityPreview(self.cityService.cities[indexPath.row])
    }
}

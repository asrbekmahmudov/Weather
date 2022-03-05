
import UIKit
import SDWebImage

class MainViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var daily: Array<WeatherForecast> = Array()
    var weekly: Array<WeatherForecast> = Array()
    var fully: Array<WeatherForecast> = Array()
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar(frame: .zero)
        search.placeholder = "Search"
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        search.searchTextField.backgroundColor = .systemGray4
        return search
    }()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.alwaysBounceVertical = true
        scroll.showsVerticalScrollIndicator = false
        view.addSubview(scroll)
        return scroll
    }()
    
    lazy var mainView: UIView = {
        let mView = UIView(frame: .zero)
        mView.backgroundColor = .init(red: 0.5, green: 0.7, blue: 1, alpha: 0.5)
        mView.layer.cornerRadius = 20
        mView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        scrollView.addSubview(mView)
        return mView
    }()
    
    lazy var lblPlace: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textColor = .white
        lbl.text = "Tashkent"
        view.contentMode = .scaleAspectFill
        lbl.font = .systemFont(ofSize: 30, weight: .light)
        mainView.addSubview(lbl)
        return lbl
    }()
    
    lazy var lbltemp: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textColor = .white
        lbl.text = "0°C"
        lbl.font = .systemFont(ofSize: UIDevice.current.orientation.isLandscape ? UIScreen.height/4 : UIScreen.width/4, weight: .ultraLight)
        mainView.addSubview(lbl)
        return lbl
    }()
    
    lazy var lblmain: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textColor = .white
        lbl.text = "Clear Sky"
        lbl.font = .systemFont(ofSize: 20, weight: .regular)
        mainView.addSubview(lbl)
        return lbl
    }()
    
    lazy var lblhumiditywind: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textColor = .white
        lbl.text = "Humidity:50%  Wind:1.5m/s"
        lbl.font = .systemFont(ofSize: 20, weight: .regular)
        mainView.addSubview(lbl)
        return lbl
    }()
    
    lazy var dailyForecastCollectionView: UICollectionView = {
        var collectionView: UICollectionView!
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.layer.cornerRadius = 10
        collectionView.backgroundColor = .init(red: 0.5, green: 0.7, blue: 1, alpha: 0)
        collectionView.showsHorizontalScrollIndicator = false
        mainView.addSubview(collectionView)
        return collectionView
    }()
    
    lazy var weeklyForecastCollectionView: UICollectionView = {
        var collectionView: UICollectionView!
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.layer.cornerRadius = 10
        collectionView.backgroundColor = .init(red: 0.5, green: 0.7, blue: 1, alpha: 0)
        collectionView.showsHorizontalScrollIndicator = false
        mainView.addSubview(collectionView)
        return collectionView
    }()
    
    lazy var fullyForecastCollectionView: UICollectionView = {
        var collectionView: UICollectionView!
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.layer.cornerRadius = 10
        collectionView.backgroundColor = .init(red: 0.5, green: 0.7, blue: 1, alpha: 0)
        collectionView.showsHorizontalScrollIndicator = false
        mainView.addSubview(collectionView)
        return collectionView
    }()
    
    lazy var lblDailyForecast: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "Daily Forecast"
        lbl.textColor = .white
        mainView.addSubview(lbl)
        return lbl
    }()
    
    lazy var lblWeeklyForecast: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "Weekly Forecast"
        lbl.textColor = .white
        mainView.addSubview(lbl)
        return lbl
    }()
    
    lazy var lblFullyForecast: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "All Forecast"
        lbl.textColor = .white
        mainView.addSubview(lbl)
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpDate()
        setUpCollections()
        setUpSearchBar()
        setUpConstraints()
    }
    
    // MARK: - Methods
    func setUpDate() {
        let city: String = "Tashkent"
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(formatCity(city: city))&appid=4bc66af9997a97a30a70d011205e7736&units=metric")
        pullJSONData(url: url, city: "Tashkent")
    }
    
    func setUpSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.layer.cornerRadius = 20
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let city: String = searchBar.text!
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(formatCity(city: city))&appid=4bc66af9997a97a30a70d011205e7736&units=metric")
         
        pullJSONData(url: url, city: city)
        searchBar.resignFirstResponder()
        daily.removeAll()
        weekly.removeAll()
        fully.removeAll()
    }
    
    // MARK: - Collection View
    func setUpCollections() {
        dailyForecastCollectionView.delegate = self
        dailyForecastCollectionView.dataSource = self
        
        weeklyForecastCollectionView.delegate = self
        weeklyForecastCollectionView.dataSource = self
        
        fullyForecastCollectionView.delegate = self
        fullyForecastCollectionView.dataSource = self
        
        self.dailyForecastCollectionView.register(UINib(nibName: "WeatherForecastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        if let flowLayout = dailyForecastCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: 50, height: 100)
            flowLayout.sectionInset.left = 15
            flowLayout.sectionInset.right = 15
        }
        
        self.weeklyForecastCollectionView.register(UINib(nibName: "WeatherForecastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
                
        if let flowLayout = weeklyForecastCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: 50, height: 100)
            flowLayout.sectionInset.left = 15
            flowLayout.sectionInset.right = 15
        }
        
        self.fullyForecastCollectionView.register(UINib(nibName: "WeatherForecastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        if let flowLayout = fullyForecastCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: 50, height: 100)
            flowLayout.sectionInset.left = 15
            flowLayout.sectionInset.right = 15
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.dailyForecastCollectionView {
            return daily.count
        } else if collectionView == self.weeklyForecastCollectionView {
            return weekly.count
        } else if collectionView == self.fullyForecastCollectionView {
            return fully.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: WeatherForecastCollectionViewCell!
        
        if collectionView == self.dailyForecastCollectionView {
            
            let day = daily[indexPath.row]
            let dailyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! WeatherForecastCollectionViewCell
            dailyCell.time.text = day.time
            let url = URL.init(string: day.image!)
            dailyCell.image.sd_setImage(with: url, placeholderImage: nil)
            dailyCell.celsius.text = day.celsius
            cell = dailyCell
            
        } else if collectionView == self.weeklyForecastCollectionView {
            
            let week = weekly[indexPath.row]
            let weeklyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! WeatherForecastCollectionViewCell
            weeklyCell.time.text = week.time
            let url = URL.init(string: week.image!)
            weeklyCell.image.sd_setImage(with: url, placeholderImage: nil)
            weeklyCell.celsius.text = week.celsius
            cell = weeklyCell
            
        } else if collectionView == self.fullyForecastCollectionView {
            
            let ful = fully[indexPath.row]
            let fullyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! WeatherForecastCollectionViewCell
            fullyCell.time.text = ful.time
            let url = URL.init(string: ful.image!)
            fullyCell.image.sd_setImage(with: url, placeholderImage: nil)
            fullyCell.celsius.text = ful.celsius
            cell = fullyCell
            
        }
        return cell
    }
}

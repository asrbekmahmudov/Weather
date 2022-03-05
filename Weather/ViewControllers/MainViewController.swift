
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
        view.contentMode = .scaleAspectFill
        lbl.font = .systemFont(ofSize: 30, weight: .light)
        mainView.addSubview(lbl)
        
        return lbl
    }()
    
    lazy var lbltemp: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: UIDevice.current.orientation.isLandscape ? UIScreen.height/4 : UIScreen.width/4, weight: .ultraLight)
        mainView.addSubview(lbl)
        
        return lbl
    }()
    
    lazy var lblmain: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 20, weight: .regular)
        mainView.addSubview(lbl)
        
        return lbl
    }()
    
    lazy var lblhumiditywind: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textColor = .white
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
        
        self.dailyForecastCollectionView.register(UINib(nibName: "WeatherForecastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        if let flowLayout = dailyForecastCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: 50, height: 100)
            flowLayout.sectionInset.left = 15
            flowLayout.sectionInset.right = 15
        }
        
        self.weeklyForecastCollectionView.register(UINib(nibName: "WeatherForecastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
                
        if let flowLayout = weeklyForecastCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: 50, height: 100)
            flowLayout.sectionInset.left = 15
            flowLayout.sectionInset.right = 15
        }
        
        self.fullyForecastCollectionView.register(UINib(nibName: "WeatherForecastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
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
        let weatherItem = { [self] () -> WeatherForecast in
            switch collectionView {
            case dailyForecastCollectionView:
                return daily[indexPath.row]
            case weeklyForecastCollectionView:
                return weekly[indexPath.row]
            default:
                return fully[indexPath.row]
            }
        }
        
        let weatherForecast: WeatherForecast! = weatherItem()
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeatherForecastCollectionViewCell
        cell.time.text = weatherForecast.time
        let url = URL.init(string: weatherForecast.image!)
        cell.image.sd_setImage(with: url, placeholderImage: nil)
        cell.celsius.text = weatherForecast.celsius
        
        return cell
    }
}

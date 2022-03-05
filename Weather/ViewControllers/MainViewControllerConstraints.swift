
import Foundation
import SnapKit
import UIKit

extension MainViewController {
    func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        lblPlace.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.top)
            make.height.equalTo(100)
            make.centerX.equalTo(mainView)
        }
        
        lbltemp.snp.makeConstraints { make in
            make.top.equalTo(lblPlace.snp.bottom)
            make.centerX.equalTo(mainView)
        }
        
        lblmain.snp.makeConstraints { make in
            make.top.equalTo(lbltemp.snp.bottom)
            make.centerX.equalTo(mainView)
        }
        
        lblhumiditywind.snp.makeConstraints { make in
            make.top.equalTo(lblmain.snp.bottom).offset(10)
            make.centerX.equalTo(mainView)
        }
        
        lblDailyForecast.snp.makeConstraints { make in
            make.top.equalTo(lblhumiditywind.snp.bottom).offset(30)
            make.left.right.equalTo(view.safeAreaLayoutGuide).offset(15)
        }
        
        dailyForecastCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lblDailyForecast.snp.bottom).offset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(100)
        }
        
        lblWeeklyForecast.snp.makeConstraints { make in
            make.top.equalTo(dailyForecastCollectionView.snp.bottom).offset(20)
            make.left.right.equalTo(view.safeAreaLayoutGuide).offset(15)
        }
        
        weeklyForecastCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lblWeeklyForecast.snp.bottom).offset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(100)
        }
        
        lblFullyForecast.snp.makeConstraints { make in
            make.top.equalTo(weeklyForecastCollectionView.snp.bottom).offset(20)
            make.left.right.equalTo(view.safeAreaLayoutGuide).offset(15)
        }
        
        fullyForecastCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lblFullyForecast.snp.bottom).offset(10)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(100)
            make.bottom.equalTo(mainView).offset(-15)
        }
    }
}

extension UIScreen {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}


import Foundation
import SnapKit

extension MainViewController {
    func setUpConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.size.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.edges.equalToSuperview()
            make.size.equalToSuperview()
        }
        
        lblPlace.snp.makeConstraints { make in
            make.top.equalTo(mainView.safeAreaLayoutGuide).offset(32)
            make.centerX.equalTo(mainView)
        }
        
        lbltemp.snp.makeConstraints { make in
            make.top.equalTo(lblPlace.snp.bottom).offset(0)
            make.centerX.equalTo(mainView)
        }
        
        lblmain.snp.makeConstraints { make in
            make.top.equalTo(lbltemp.snp.bottom).offset(0)
            make.centerX.equalTo(mainView)
        }
        
        lblhumiditywind.snp.makeConstraints { make in
            make.top.equalTo(lblmain.snp.bottom).offset(10)
            make.centerX.equalTo(mainView)
        }
        
        lblDailyForecast.snp.makeConstraints { make in
            make.top.equalTo(lblhumiditywind.snp.bottom).offset(50)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        
        dailyForecastCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lblDailyForecast.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(100)
        }
        
        lblWeeklyForecast.snp.makeConstraints { make in
            make.top.equalTo(dailyForecastCollectionView.snp.bottom).offset(30)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        
        weeklyForecastCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lblWeeklyForecast.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(100)
        }
        
        lblMonthlyForecast.snp.makeConstraints { make in
            make.top.equalTo(weeklyForecastCollectionView.snp.bottom).offset(30)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        
        fullyForecastCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lblMonthlyForecast.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(100)
        }
        
        
    }
}



import Foundation
import SnapKit

extension WeatherForecastCollectionViewCell {
    func setUpConstraints() {
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.size.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        time.snp.makeConstraints { make in
            make.top.equalTo(mainView.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
        }
        
        image.snp.makeConstraints { make in
            make.top.equalTo(time.snp.bottom).offset(-5)
            make.centerX.equalToSuperview()
        }
        
        celsius.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(-5)
            make.centerX.equalToSuperview()
        }
        
    }
}

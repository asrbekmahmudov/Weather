
import UIKit

class WeatherForecastCollectionViewCell: UICollectionViewCell {

    lazy var mainView: UIView = {
        let mView = UIView(frame: .zero)
        mView.backgroundColor = .init(red: 0.5, green: 0.7, blue: 1, alpha: 0.5)
        mView.layer.cornerRadius = 10
        addSubview(mView)
        return mView
    }()
    
    lazy var time: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = .systemFont(ofSize: 15)
        lbl.textColor = .white
        mainView.addSubview(lbl)
        return lbl
    }()
    
    lazy var image: UIImageView = {
        let img = UIImageView(frame: .zero)
        mainView.addSubview(img)
        return img
    }()
    
    lazy var celsius: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = .systemFont(ofSize: 15)
        lbl.textColor = .white
        mainView.addSubview(lbl)
        return lbl
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpConstraints()
    }

}

//
//  WeatherForecastCollectionViewCell.swift
//  Weather
//
//  Created by Mahmudov Asrbek Ulug'bek o'g'li on 04/03/22.
//

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
        lbl.text = "now"
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
        lbl.text = "30°"
        lbl.textColor = .white
        mainView.addSubview(lbl)
        return lbl
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpConstraints()
    }

}
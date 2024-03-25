//
//  MainInfoCell.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 23.03.2024.
//

import UIKit

final class MainInfoCell: UICollectionViewCell {
    
    public static let identifier: String = "MainInfoCell"
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.axis = .vertical
        return sv
    }()
    
    private let locationLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "ColoredCardTextColor")
        label.text = "Location Name"
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "0°"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 81, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "ColoredCardTextColor")
        return label
    }()
    
    private let secondaryStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .center
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        return sv
    }()
    
    private let windspeedView: ParameterView = {
        let view = ParameterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let cloudCoverView: ParameterView = {
        let view = ParameterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let precibView: ParameterView = {
        let view = ParameterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        self.backgroundColor = .init(named: "VKBlue")
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.08).cgColor
        self.layer.borderWidth = 0.33
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30)
        ])
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(secondaryStackView)
        secondaryStackView.addArrangedSubview(windspeedView)
        secondaryStackView.addArrangedSubview(cloudCoverView)
        secondaryStackView.addArrangedSubview(precibView)
    }
}

extension MainInfoCell {
    func bind(_ viewModel: MainInfoViewModel) {
        self.locationLabel.text = viewModel.locationName
        self.temperatureLabel.text = viewModel.temp
        self.windspeedView.configure(iconName: "wind", bottomText: viewModel.windspeed)
        self.cloudCoverView.configure(iconName: "cloud.fill", bottomText: viewModel.cloudCover)
        self.precibView.configure(iconName: "cloud.drizzle.fill", bottomText: viewModel.precibProb)
    }
}

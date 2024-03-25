//
//  CityCell.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 24.03.2024.
//

import UIKit

final class CityCell: UICollectionViewCell {
    
    public static let identifier = "CityCell"
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textAlignment = .left
        label.text = "-"
        return label
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
        contentView.addSubview(cityNameLabel)
        NSLayoutConstraint.activate([
            cityNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            cityNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cityNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            cityNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(_ city: String) {
        cityNameLabel.text = city
    }
}

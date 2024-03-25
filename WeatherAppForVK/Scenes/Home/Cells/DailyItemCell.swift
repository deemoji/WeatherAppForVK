//
//  DailyItemCell.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 23.03.2024.
//

import UIKit

final class DailyItemCell: UICollectionViewCell {
    
    static let identifier: String = "DailyItemCell"
    
    private let weekdayLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Text"
        label.textColor = UIColor(named: "TextColor")
        return label
    }()
    private let monthDayLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Text"
        label.textColor = .lightGray
        return label
    }()
    private let weatherImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage()
        return iv
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0°"
        label.textColor = UIColor(named: "TextColor")
        return label
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0°"
        label.textColor = .lightGray
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .systemPink : .clear
        }
    }
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .center
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let dateStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .fill
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    private let tempStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .center
        sv.axis = .horizontal
        sv.spacing = 0
        sv.distribution = .fillEqually
        return sv
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
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
        ])
        stackView.addArrangedSubview(dateStackView)
        dateStackView.addArrangedSubview(monthDayLabel)
        dateStackView.addArrangedSubview(weekdayLabel)
        stackView.addArrangedSubview(weatherImageView)
        stackView.addArrangedSubview(tempStackView)
        tempStackView.addArrangedSubview(UIView()) // Temp labels gets closer to each other
        tempStackView.addArrangedSubview(maxTempLabel)
        tempStackView.addArrangedSubview(minTempLabel)
    }
    
}
extension DailyItemCell {
    func bind(_ viewModel: DailyItemViewModel) {
        self.monthDayLabel.text = viewModel.monthDay
        self.weekdayLabel.text = viewModel.weekday
        self.weatherImageView.image = UIImage(named: viewModel.icon)
        self.maxTempLabel.text = viewModel.maxTemp
        self.minTempLabel.text = viewModel.minTemp
    }
}

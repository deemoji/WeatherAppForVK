//
//  ParameterView.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 24.03.2024.
//

import UIKit

final class ParameterView: UIView {
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .center
        sv.distribution = .equalCentering
        sv.axis = .vertical
        return sv
    }()
    
    let iconView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = UIColor(named: "ColoredCardTextColor")
        return iv
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "0°"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "ColoredCardTextColor")
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
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
        stackView.addArrangedSubview(iconView)
        stackView.addArrangedSubview(bottomLabel)
    }
    
    func configure(iconName: String, bottomText: String) {
        iconView.image = UIImage(systemName: iconName)
        bottomLabel.text = bottomText
    }
}

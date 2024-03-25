//
//  BackgroundSupplementaryView.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 23.03.2024.
//

import UIKit

final class BackgroundSupplementaryView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    func setupViews() {
        layer.cornerRadius = 10.0
        backgroundColor = .init(named: "CardColor")
        layer.borderColor = UIColor.black.withAlphaComponent(0.08).cgColor
        layer.borderWidth = 0.33
    }
}

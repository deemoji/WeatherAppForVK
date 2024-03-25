//
//  WeatherView.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 22.03.2024.
//

import UIKit

final class WeatherView: UIView {
    
    enum Section: Int {
        case mainInfo
        case days
    }
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: createLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    private  func setupViews() {
        collectionView.backgroundColor = .clear
        collectionView.allowsSelection = false
        let views = [collectionView]
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo:  self.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
    }
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self = self else {return nil}
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            switch sectionKind {
            case .mainInfo:
                return self.createMainSection()
            case .days:
                return self.createListSection()
            }
            
        }
        layout.register(BackgroundSupplementaryView.self, forDecorationViewOfKind: "background")
        return layout
    }
    private func createMainSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                         heightDimension: .fractionalHeight(0.3)),
                                                       subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }
    
    private func createListSection() -> NSCollectionLayoutSection {
        let bounds = UIScreen.main.bounds
        let cellSize = bounds.height * 0.08
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                         heightDimension: .estimated(cellSize)),
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let sectionInset = 16.0
        section.contentInsets = .init(top: sectionInset, leading: sectionInset, bottom: sectionInset, trailing: sectionInset)
        let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
        let backgroundInset: CGFloat = 8
        backgroundItem.contentInsets = NSDirectionalEdgeInsets(top: backgroundInset, leading: backgroundInset, bottom: backgroundInset, trailing: backgroundInset)
        section.decorationItems = [backgroundItem]
        return section
    }
    
}

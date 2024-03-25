//
//  ViewController.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 21.03.2024.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<HomeViewModel.Section, HomeItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<HomeViewModel.Section, HomeItem>
    
    var viewModel: HomeViewModel!
    
    private var contentView = WeatherView()
    private let refreshControl = UIRefreshControl()
    
    private var dataSource: DataSource!
    
    private var bag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTriggered), for: .valueChanged)
        view.backgroundColor = .init(named: "BackgroundColor")
        contentView.collectionView.register(MainInfoCell.self, forCellWithReuseIdentifier: MainInfoCell.identifier)
        contentView.collectionView.register(DailyItemCell.self, forCellWithReuseIdentifier: DailyItemCell.identifier)
        configureDataSource()
        bindViewModel()
        viewModel.fetchWeather()
    }
    
    override func loadView() {
        view = contentView
    }
    @objc func refreshTriggered() {
        viewModel.fetchWeather()
    }
    
    private func updateSections(_ value: Weather.Responce) {
        var snapshot = Snapshot()
        snapshot.appendSections([.mainInfo, .dailyItems])
        
        if value.days.count > 0 {
            let mainInfo = MainInfoViewModel(value.address, day: value.days[0])
            
            snapshot.appendItems([.mainInfo(mainInfo)], toSection: .mainInfo)
        }
        var items = value.days
            .map { HomeItem.dailyItem(DailyItemViewModel(day: $0)) }
        if(value.days.count > 7){
            items = items.dropLast(value.days.count - 7)
        }
        snapshot.appendItems(items, toSection: .dailyItems)
        dataSource.apply(snapshot)
    }
    private func configureDataSource() {
        dataSource = DataSource(collectionView: contentView.collectionView) { collectionView, indexPath, item in
            switch item {
            case .mainInfo(let mainInfoViewModel):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainInfoCell.identifier, for: indexPath) as? MainInfoCell
                cell?.bind(mainInfoViewModel)
                return cell
            case .dailyItem(let dailyItemViewModel):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyItemCell.identifier, for: indexPath) as? DailyItemCell
                cell?.bind(dailyItemViewModel)
                return cell
            }
            
        }
    }
    private func bindViewModel() {
        viewModel.$state.sink {[weak self] state in
            switch state {
            case .loading:
                self?.refreshControl.beginRefreshing()
            case .finishedLoading:
                self?.refreshControl.endRefreshing()
            case .error(let error):
                self?.showError(error)
                self?.refreshControl.endRefreshing()
            }
        }.store(in: &bag)
        
        viewModel.$weather.sink (receiveValue: { [weak self] val in
            self?.updateSections(val)
        }).store(in: &bag)
    }
    private func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
}


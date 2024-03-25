//
//  SearchViewController.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 24.03.2024.
//

import UIKit
import Combine

final class SearchViewController: UIViewController {
    struct UniqueState: Hashable {
        let uuid: UUID
        let item: String
    }
    typealias DataSource = UICollectionViewDiffableDataSource<SearchViewModel.Section, UniqueState>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SearchViewModel.Section, UniqueState>
    
    var viewModel: SearchViewModel!
    
    private let contentView = ListView()
    
    private var dataSource: DataSource!
    private var bag = Set<AnyCancellable>()
    
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.placeholder = "Find your city..."
        return sb
    }()
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        self.contentView.collectionView.delegate = self
        view.backgroundColor = UIColor(named: "BackgroundColor")
        self.navigationItem.titleView = searchBar
        navigationController?.navigationBar.tintColor = UIColor(named: "VKBlue")
        contentView.collectionView.register(CityCell.self, forCellWithReuseIdentifier: CityCell.identifier)
        configureDataSource()
        bindViewModel()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear.send()
    }
    private func updateSections(_ cities: [String]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.cities])
        snapshot.appendItems(cities.map({UniqueState(uuid: UUID(), item: $0)}))
        dataSource.apply(snapshot)
    }
    private func configureDataSource() {
        dataSource = DataSource(collectionView: contentView.collectionView, cellProvider: { collectionView, indexPath, state in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCell.identifier, for: indexPath) as? CityCell
            cell?.configure(state.item)
            return cell
        })
    }
    private func bindViewModel() {
        // Input
        searchBar.searchTextField.textPublisher
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] in
                if ($0 == "") { return }
                self?.viewModel.search(with: $0)
            }.store(in: &bag)
        // Output
        viewModel.$results.sink { [weak self] in
            self?.updateSections($0)
        }.store(in: &bag)
    }
}
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectedItem.send(indexPath.row)
    }
}

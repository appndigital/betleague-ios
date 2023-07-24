//
//  MainViewController.swift
//  betleagues-ios
//
//  Created by Didier Nizard on 24/07/2023.
//

import UIKit
import SnapKit
import Combine

class MainViewController: UIViewController {
    
    private let mainVM: MainViewModel
    private var dataLeagues: [LeagueModel] = []
    private var dataTeams: [TeamModel] = []
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private let searchController: UISearchController = {
        $0.searchBar.searchTextField.backgroundColor = .white
        $0.searchBar.searchTextField.clearButtonMode = .whileEditing
        return $0
    }(UISearchController(searchResultsController: nil))
    
    private let autoCompleteTableView = UITableView()
    private var teamCollectionView: UICollectionView!
    
    private var isSearching: Bool = true {
        didSet {
            autoCompleteTableView.isHidden = !isSearching
            teamCollectionView.isHidden = isSearching
        }
    }
    
    init(viewModel: MainViewModel = MainViewModel()) {
        mainVM = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.searchController = searchController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBindings()
        self.updateUI()
        self.configureLayout()
    }
    
    private func setBindings() {
        searchController.searchBar.delegate = self
        
        autoCompleteTableView.dataSource = self
        autoCompleteTableView.delegate = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        teamCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        teamCollectionView.dataSource = self
        teamCollectionView.delegate = self
        
        autoCompleteTableView.register(UITableViewCell.self, forCellReuseIdentifier: "LeagueCell")
        
        teamCollectionView.register(UINib(nibName: "TeamCell", bundle: nil), forCellWithReuseIdentifier: "teamCell")
        
        mainVM.$leagues.sink { list in
            self.updateData(forLeague: list)
        }.store(in: &cancellableSet)
        
        mainVM.$teams.sink { list in
            self.updateData(forTeams: list)
        }.store(in: &cancellableSet)
    }
    
    private func updateUI() {
        view.backgroundColor = .white
    }
    
    private func configureLayout() {
        view.addSubview(autoCompleteTableView)
        autoCompleteTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(teamCollectionView)
        teamCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func updateData(forLeague list: [LeagueModel]) {
        dataLeagues = list
        autoCompleteTableView.reloadData()
    }
    
    private func updateData(forTeams list: [TeamModel]) {
        dataTeams = list
        teamCollectionView.reloadData()
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            updateData(forLeague: [])
            return
        }
        
        isSearching = true
        mainVM.searchLeague(search: searchText)
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath)
        
        if indexPath.row < dataLeagues.count {
            var content = cell.defaultContentConfiguration()
            content.text = dataLeagues[indexPath.row].strLeague
            cell.contentConfiguration = content
        }
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < dataLeagues.count else { return }
        
        searchController.isActive = false
        
        isSearching = false
        mainVM.getTeams(league: dataLeagues[indexPath.row])
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataTeams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCell
        
        if indexPath.row < dataTeams.count {
            cell.data = dataTeams[indexPath.row]
        }
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       return CGSize(width: 150, height: 200)
    }
}

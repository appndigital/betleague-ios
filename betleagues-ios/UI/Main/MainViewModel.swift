//
//  MainViewModel.swift
//  betleagues-ios
//
//  Created by Didier Nizard on 24/07/2023.
//

import Foundation
import Combine

class MainViewModel {
    
    private var cancellableSet: Set<AnyCancellable> = []
    private let leagueRepository: LeagueRepositoryProtocol
    
    @Published var leagues: [LeagueModel] = []
    @Published var teams: [TeamModel] = []
    
    init(repository: LeagueRepositoryProtocol = LeagueRepository()) {
        leagueRepository = repository
    }
    
    func searchLeague(search: String) {
        self.teams = []
        leagueRepository.searchLeague(search: search)
            .sink { _ in
                
            } receiveValue: { list in
                self.leagues = list
            }.store(in: &cancellableSet)
    }
    
    func getTeams(league: LeagueModel) {
        self.leagues = []
        leagueRepository.getTeams(forLeague: league)
            .sink { _ in
                
            } receiveValue: { list in
                self.teams = list
            }.store(in: &cancellableSet)
    }
}

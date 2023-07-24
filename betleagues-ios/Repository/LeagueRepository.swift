//
//  LeagueRepository.swift
//  betleagues-ios
//
//  Created by Didier Nizard on 24/07/2023.
//

import Foundation
import Combine

protocol LeagueRepositoryProtocol {
    func searchLeague(search: String) -> AnyPublisher<[LeagueModel], BetLeagueError>
    func getTeams(forLeague _league: LeagueModel) -> AnyPublisher<[TeamModel], BetLeagueError>
}

class LeagueRepository: LeagueRepositoryProtocol {
    
    private let leagueService: LeagueServiceProtocol
    private var cancellableSet: Set<AnyCancellable> = []
    private var leagues: [LeagueModel] = []
    
    init(service: LeagueServiceProtocol = LeagueService()) {
        leagueService = service
        
        leagueService.getLeagues()
            .sink { _ in
                
            } receiveValue: { list in
                self.leagues = list.leagues
            }.store(in: &cancellableSet)
    }
    
    func searchLeague(search: String) -> AnyPublisher<[LeagueModel], BetLeagueError> {
        guard !leagues.isEmpty else { return Fail(error: BetLeagueError(msg: "leagues not init")).eraseToAnyPublisher() }
        
        return Just(
            leagues.filter{
                $0.strLeague.lowercased().contains(search.lowercased())
            }
        )
        .setFailureType(to: BetLeagueError.self)
        .eraseToAnyPublisher()
    }
    
    func getTeams(forLeague _league: LeagueModel) -> AnyPublisher<[TeamModel], BetLeagueError> {
        return leagueService.searchTeams(league: _league.strLeague)
            .map { result in
                let teams = result.teams.sorted(by: { $0.strTeam > $1.strTeam })
                return stride(from: 0, to: teams.count, by: 2).map { teams[$0] }
            }
            .eraseToAnyPublisher()
    }
}

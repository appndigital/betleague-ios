//
//  MockLeagueService.swift
//  betleagues-iosTests
//
//  Created by Didier Nizard on 24/07/2023.
//

import Foundation
import Combine
@testable import betleagues_ios

class MockLeagueService: LeagueServiceProtocol {
    
    private var leagueList: LeagueListModel
    private var teamList: TeamListModel
    
    init(leagues: LeagueListModel, teams: TeamListModel) {
        leagueList = leagues
        teamList = teams
    }
    
    func getLeagues() -> AnyPublisher<betleagues_ios.LeagueListModel, betleagues_ios.BetLeagueError> {
        Just(leagueList)
            .setFailureType(to: BetLeagueError.self)
            .eraseToAnyPublisher()
    }
    
    func searchTeams(league: String) -> AnyPublisher<betleagues_ios.TeamListModel, betleagues_ios.BetLeagueError> {
        Just(teamList)
            .setFailureType(to: BetLeagueError.self)
            .eraseToAnyPublisher()
    }
}

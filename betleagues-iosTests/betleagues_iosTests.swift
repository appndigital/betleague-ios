//
//  betleagues_iosTests.swift
//  betleagues-iosTests
//
//  Created by Didier Nizard on 24/07/2023.
//

import XCTest
import Combine
@testable import betleagues_ios

final class betleagues_iosTests: XCTestCase {

    func testFetchLeagueUseCase() {
        let leagueService = MockLeagueService(leagues: LeagueListModel.mockFull, teams: TeamListModel.mockFull)
        let leagueRepository = MockLeagueRepository(service: leagueService)
        
        do {
            let leagues = try awaitPublisher(leagueRepository.searchLeague(search: "ligue"))
            XCTAssertNotNil(leagues)
            XCTAssertEqual(leagues.count, 1)
        } catch {
            XCTFail("Unit test should not fail")
        }
    }
    
    func testFetcheamUseCase() {
        let leagueService = MockLeagueService(leagues: LeagueListModel.mockFull, teams: TeamListModel.mockFull)
        let leagueRepository = MockLeagueRepository(service: leagueService)
        
        do {
            let teams = try awaitPublisher(leagueRepository.getTeams(forLeague: LeagueModel(idLeague: "X", strLeague: "Y", strSport: "Z")))
            XCTAssertNotNil(teams)
            XCTAssertEqual(teams.count, 2)
        } catch {
            XCTFail("Unit test should not fail")
        }
    }

}

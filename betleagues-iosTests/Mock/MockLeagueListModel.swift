//
//  MockLeagueListModel.swift
//  betleagues-iosTests
//
//  Created by Didier Nizard on 24/07/2023.
//

import Foundation
@testable import betleagues_ios

extension LeagueListModel {
    
    static var mockFull: LeagueListModel = {
        LeagueListModel(
            leagues: [
                LeagueModel(
                    idLeague: "4328",
                    strLeague: "English Premier League",
                    strSport: "Soccer",
                    strLeagueAlternate: "Premier League, EPL"
                ),
                LeagueModel(
                    idLeague: "4332",
                    strLeague: "Italian Serie A",
                    strSport: "Soccer",
                    strLeagueAlternate: "Serie A"
                ),
                LeagueModel(
                    idLeague: "4334",
                    strLeague: "French Ligue 1",
                    strSport: "Soccer",
                    strLeagueAlternate: "Ligue 1 Conforama"
                )
            ]
        )
    }()
    
    static var mockEmpty: LeagueListModel = {
        LeagueListModel(
            leagues: []
        )
    }()
    
}

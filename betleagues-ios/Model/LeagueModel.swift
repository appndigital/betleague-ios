//
//  League.swift
//  betleagues-ios
//
//  Created by Didier Nizard on 24/07/2023.
//

import Foundation

struct LeagueListModel: Codable {
    var leagues: [LeagueModel]
}

struct LeagueModel: Codable {
    var idLeague: String
    var strLeague: String
    var strSport: String
    var strLeagueAlternate: String?
}

//
//  MockTeamListModel.swift
//  betleagues-iosTests
//
//  Created by Didier Nizard on 24/07/2023.
//

import Foundation
@testable import betleagues_ios

extension TeamListModel {
    
    static var mockFull: TeamListModel = {
        TeamListModel(
            teams: [
                TeamModel(idTeam: "133704", strTeam: "Brest"),
                TeamModel(idTeam: "134713", strTeam: "Clermont Foot Auvergne 63"),
                TeamModel(idTeam: "133862", strTeam: "Le Havre"),
                TeamModel(idTeam: "133822", strTeam: "Lens")
            ]
        )
    }()
    
    static var mockEmpty: TeamListModel = {
        TeamListModel(
            teams: []
        )
    }()
    
}

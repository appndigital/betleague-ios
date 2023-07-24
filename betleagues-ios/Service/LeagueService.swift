//
//  LeagueService.swift
//  betleagues-ios
//
//  Created by Didier Nizard on 24/07/2023.
//

import Foundation
import Alamofire
import Combine

protocol LeagueServiceProtocol {
    func getLeagues() -> AnyPublisher<LeagueListModel, BetLeagueError>
    func searchTeams(league: String) -> AnyPublisher<TeamListModel, BetLeagueError>
}

class LeagueService: LeagueServiceProtocol {
    
    func getLeagues() -> AnyPublisher<LeagueListModel, BetLeagueError> {
        guard let url = URL(string: Constants.apiURL + "all_leagues.php") else { return Fail(error: BetLeagueError(msg: "url error")).eraseToAnyPublisher() }
        
        return Future<LeagueListModel, BetLeagueError> { promise in
            
            AF.request(url, method: .get)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: LeagueListModel.self) { response in
                    switch response.result {
                    case .success(let value):
                        promise(.success(value))
                        break
                        
                    case .failure(let error):
                        print(error)
                        promise(.failure(BetLeagueError(msg: error.localizedDescription)))
                        break
                    }
                }
        }
        .eraseToAnyPublisher()
    }
    
    func searchTeams(league: String) -> AnyPublisher<TeamListModel, BetLeagueError> {
        guard let parameter = league.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL(string: Constants.apiURL + "search_all_teams.php?l=" + parameter) else { return Fail(error: BetLeagueError(msg: "url error")).eraseToAnyPublisher() }
        
        return Future<TeamListModel, BetLeagueError> { promise in
            
            AF.request(url, method: .get)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: TeamListModel.self) { response in
                    switch response.result {
                    case .success(let value):
                        promise(.success(value))
                        break
                        
                    case .failure(let error):
                        print(error)
                        promise(.failure(BetLeagueError(msg: error.localizedDescription)))
                        break
                    }
                }
        }
        .eraseToAnyPublisher()
    }
    
}

//
//  ListMoviesRepo.swift
//  Movies_V2
//
//  Created by Ahmed Aly on 04/03/2024.
//

import Foundation
protocol CharacterListReposing {
    func fetchCharacterList(service: Services, data: [String: Any]?, completion: @escaping (Result<CharacterPage, Error>) -> Void)
}

class CharacterListRepo: CharacterListReposing {
    private let networkManager: APIHandling
    
    init(networkManager: APIHandling = APIHandler()) {
        self.networkManager = networkManager
    }
    
    func fetchCharacterList(service: Services = .characterList, data: [String: Any]?, completion: @escaping (Result<CharacterPage, Error>) -> Void) {
        self.networkManager.executeQuery(service: service, data: data, method: APIMethod.GET) { (result: Result<CharacterPage, Error>) in
            completion(result)
        }
    }
}

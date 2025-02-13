//
//  NetworkSessionMock.swift
//  Yassir
//
//  Created by Ahmed Aly on 11/02/2025.
//

import Foundation
class NetworkSessionMock: NetworkSession {
    private(set) var requestUrl: URL?
    var data: Data?
    var error: Error?

    func loadData(with urlRequest: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        requestUrl = urlRequest.url
        completionHandler(data, error)
    }
}


class DataFixtures {
    static var charactersDataSuccessful: Data? { return jsonData("CharactersList") }
    static var charactersDataFailure: Data? { return jsonData("CharactersListError") }
    static var charactersDataNextPageSuccessful: Data? { return jsonData("CharactersListNextPage") }
    static var CharactersListAliveSuccessful: Data? { return jsonData("CharactersListAlive") }

    private static func jsonData(_ filename: String) -> Data? {
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else {
            print("❌ Error: File \(filename).json not found")
            return nil
        }
        
        do {
            return try Data(contentsOf: URL(fileURLWithPath: path))
        } catch {
            print("❌ Error loading \(filename).json: \(error)")
            return nil
        }
    }
}

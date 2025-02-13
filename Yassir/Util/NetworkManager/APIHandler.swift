//
//  APIHandler.swift
//  Yassir
//
//  Created by Ahmed Aly on 11/02/2025.
//

import Foundation

protocol APIHandling {
    func executeQuery<T>(service: Services, data: [String:Any]?,  method: APIMethod, completion: @escaping (Result<T, Error>) -> Void)  where T: Codable
}
let BASE_URL :String = "https://rickandmortyapi.com/api/"
enum Services {
    case characterList
    case characterNextPage(String)
    
    var api: String {
        switch self {
        case .characterList:
            return "\(BASE_URL)character"
        case .characterNextPage(let nextURL):
            return nextURL
        }
    }
}

enum APIMethod: String {
    case GET = "GET"
    case POST = "POST"
}

class APIHandler: APIHandling {
    private let manager: EndPointsManaging
    
    init(manager: EndPointsManaging = EndPointsManager()) {
        self.manager = manager
    }
    
    func executeQuery<T>(service: Services, data: [String:Any]?,  method: APIMethod, completion: @escaping (Result<T, Error>) -> Void)  where T: Codable {
        
        guard let request = getURLRequest(service: service, data: data, method: method) else { return  }
        
        manager.makeRequest(with: request as URLRequest, completionHandler: { response in
            switch response {
            case let .success(result):
                do {
                    let jsonDecoder = JSONDecoder()
                    let parsed = try jsonDecoder.decode(T.self, from: result)
                    completion(.success(parsed))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        })
    }
    
    private func getURLRequest(service: Services, data: [String:Any]?, method: APIMethod) -> URLRequest? {
        let headers = [
          "accept": "application/json",
        ]
        let urlPath = service.api
        var components = URLComponents(string: urlPath)!
        if let params = data {
            components.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        let request: NSMutableURLRequest
        guard let url = components.url else { return nil }
        
        request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        return request as URLRequest?
    }
}

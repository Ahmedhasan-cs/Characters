//
//  EndPointsManager.swift
//  Yassir
//
//  Created by Ahmed Aly on 11/02/2025.
//

import Foundation


protocol EndPointsManaging {
    func makeRequest (
        with request: URLRequest,
        completionHandler: @escaping (Result<Data, Error>) -> Void
    )
}

class EndPointsManager: EndPointsManaging {
    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    func makeRequest (
        with request: URLRequest,
        completionHandler: @escaping (Result<Data, Error>) -> Void
    ) {
        session.loadData(with: request) { data, error in
            guard let data = data else {
                completionHandler(.failure(error!))
                return
            }
            
            if let error = error {
                completionHandler(.failure(error))
            } else {
                completionHandler(.success(data))
            }
        }
    }
}

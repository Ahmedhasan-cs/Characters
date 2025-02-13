//
//  NetworkSession.swift
//  Yassir
//
//  Created by Ahmed Aly on 11/02/2025.
//

import Foundation
protocol NetworkSession {
    func loadData(with urlRequest: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
  func loadData(with urlRequest: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
    let task = dataTask(with: urlRequest) { (data, _, error) in
        completionHandler(data, error)
    }

    task.resume()
  }
}


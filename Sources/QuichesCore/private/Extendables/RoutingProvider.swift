//
//  RoutingProvider.swift
//  
//
//  Created by Maxence Mottard on 25/03/2021.
//

import Foundation

protocol RoutingProvider {}

extension RoutingProvider {
    private func send<T: Routing>(with routing: T, completion: @escaping (Result<Data?, Error>) -> Void) {
        guard let request = routing.urlRequest else {
            completion(.failure(NSError(domain: "UNKNOW_ERROR", code: 500, userInfo: nil)))

            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let response = urlResponse as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "UNKNOW_ERROR", code: 500, userInfo: nil)))

                return
            }
            
            if routing.successStatusCodes.contains(response.statusCode) {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
                
                return
            } else {
                completion(.failure(NSError(domain: "UNKNOW_ERROR", code: 500, userInfo: nil)))
                
                return
            }
        }.resume()
    }
    
    func execute<T: Routing>(
        with routing: T,
        completion: @escaping (Result<Void, Error>) -> Void
    ) where T.DecodeType == EmptyCodable {

        send(with: routing) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(_):
                completion(.success(()))
            }
        }
    }
    
    func execute<T: Routing>(
        with routing: T,
        completion: @escaping (Result<T.DecodeType, Error>) -> Void
    ) where T.DecodeType: Decodable {

        send(with: routing) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    guard let data = data else {
                        completion(.failure(NSError(domain: "UNKNOW_ERROR", code: 500, userInfo: nil)))
                        
                        return
                    }
                    let decoded = try JSONDecoder().decode(T.DecodeType.self, from: data)
                    
                    completion(.success(decoded))
                } catch (let error) {
                    completion(.failure(error))
                }
            }
        }
    }
}

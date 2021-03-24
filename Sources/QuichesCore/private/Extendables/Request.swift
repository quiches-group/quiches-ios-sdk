//
//  Request.swift
//  
//
//  Created by Maxence Mottard on 24/03/2021.
//

import Foundation

protocol Request: Weakable {
    var method: HTTPMethod { get }
    func generateRequest(url: URL) -> URLRequest?
}

extension Request {
    func encodeBody<T: Encodable>(with parameters: T) -> Data? {
        do {
            return try JSONEncoder().encode(parameters)
        } catch {
            return nil
        }
    }
    
    func executeRequest(
        with request: URLRequest,
        completionHandler: @escaping (Result<(URLResponse, Data?), Error>) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let response = urlResponse as? HTTPURLResponse else {
                completionHandler(.failure(NSError(domain: "UNKNOW_ERROR", code: 500, userInfo: nil)))

                return
            }
            
            if let error = error {
                completionHandler(.failure(error))
                
                return
            } else {
                completionHandler(.success((response, data)))
                
                return
            }
        }.resume()
    }
    
    func generateUrl(with urlString: String) -> URL? {
        let url = URL(string: urlString)
        return url
    }
}

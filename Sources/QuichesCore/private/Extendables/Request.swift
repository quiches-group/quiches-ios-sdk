//
//  Request.swift
//  
//
//  Created by Maxence Mottard on 24/03/2021.
//

import Foundation

protocol Request: Weakable {
    var method: HTTPMethod { get }
    var url: URL? { get set }
    var request: URLRequest? { get set }
    
    func generateUrl()
    func generateRequest()
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
        successHandler: @escaping (URLResponse, Data?) -> Void,
        errorHandler: ((Error) -> Void)? = nil
    ) {
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error {
                errorHandler?(error)
            } else if let urlResponse = urlResponse {
                successHandler(urlResponse, data)
            } else {
                //  handle new error
            }
        }.resume()
    }
}

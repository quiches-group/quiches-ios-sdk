//
//  File.swift
//  
//
//  Created by Maxence Mottard on 24/03/2021.
//

import Foundation

struct LoginWebServiceParameters: Encodable {
    let mail: String
    let password: String
}

public struct LoginWebServiceResponse: Decodable {
    let token: String
    let refreshToken: String
}

public final class LoginWebService: Request {
    private let hostname = Config.Hostname.sso.rawValue
    
    private let publicKey: String
    internal let method: HTTPMethod = .POST
    
    private let decoder: JSONDecoder = JSONDecoder()
    
    init(publicKey: String) {
        self.publicKey = publicKey
    }
    
    internal func generateRequest(url: URL) -> URLRequest? {
        var request = URLRequest(url: url)

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = method.rawValue
        
        return request
    }
    
    func send(
        parameters: LoginWebServiceParameters,
        completion completionHandler: @escaping (Result<LoginWebServiceResponse, Error>) -> Void
    ) {
        guard let url = generateUrl(with: "\(hostname)/application-users/login?publicKey=\(publicKey)"),
              var request = generateRequest(url: url),
              let body = encodeBody(with: parameters) else { return }
        
        request.httpBody = body

        executeRequest(with: request, completionHandler: { [decoder] result in
            switch result {
            case .success((_, let data)):
                guard let data = data else { return }
                
                do {
                    let response = try decoder.decode(LoginWebServiceResponse.self, from: data)
                    completionHandler(.success(response))
                } catch (let error) {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
}


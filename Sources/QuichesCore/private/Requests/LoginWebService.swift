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

struct LoginWebServiceResponse: Decodable {
    let token: String
    let refreshToken: String
}

final class LoginWebService: Weakable {
    private let hostname = Config.Hostname.sso.rawValue
    private let method: HTTPMethod = .POST
    
    private let publicKey: String
    private var url: URL?
    private var request: URLRequest?
    
    private let encoder: JSONEncoder = JSONEncoder()
    private let decoder: JSONDecoder = JSONDecoder()
    
    init(publicKey: String) {
        self.publicKey = publicKey
        generateUrl()
    }
    
    private func generateUrl() {
        url = URL(string: "\(hostname)/users/login")
    }
    
    private func generateRequest() {
        guard let url = url else { return }
        
        var request = URLRequest(url: url)

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = method.rawValue
    }
    
    func send(parameters: LoginWebServiceParameters, onSuccess: @escaping (LoginWebServiceResponse) -> Void) {
        guard var request = request else { return }
        
        do {
            request.httpBody = try encoder.encode(parameters)
            
            URLSession.shared.dataTask(with: request, completionHandler: weakify { strongSelf, data, urlResponse, error in
                guard let data = data else { return }
                
                do {
                    let response = try strongSelf.decoder.decode(LoginWebServiceResponse.self, from: data)
                    
                    onSuccess(response)
                } catch (let error) {
                    print(error)
                }
            })
        } catch (let error) {
            print(error)
        }
    }
}


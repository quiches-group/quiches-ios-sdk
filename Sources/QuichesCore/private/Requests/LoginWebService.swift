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

final class LoginWebService: Request {
    private let hostname = Config.Hostname.sso.rawValue
    
    private let publicKey: String
    internal let method: HTTPMethod = .POST
    internal var url: URL?
    internal var request: URLRequest?
    
    private let decoder: JSONDecoder = JSONDecoder()
    
    init(publicKey: String) {
        self.publicKey = publicKey
        generateUrl()
        generateRequest()
    }
    
    internal func generateUrl() {
        url = URL(string: "\(hostname)/users/login")
    }
    
    internal func generateRequest() {
        guard let url = url else { return }
        
        var request = URLRequest(url: url)

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = method.rawValue
    }
    
    func send(
        parameters: LoginWebServiceParameters,
        onSuccess successHandler: @escaping (LoginWebServiceResponse) -> Void,
        onError errorHandler: ((Error) -> Void)? = nil
    ) {
        guard var request = request,
              let body = encodeBody(with: parameters) else { return }
        
        request.httpBody = body
        
        executeRequest(with: request, successHandler: weakify { (strongSelf, urlResponse, data) in
            guard let data = data else { return }
            
            do {
                let response = try strongSelf.decoder.decode(LoginWebServiceResponse.self, from: data)
                successHandler(response)
            } catch (let error) {
                errorHandler?(error)
            }
        }, errorHandler: errorHandler)
    }
}


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

struct TokenPair: Decodable {
    let token: String
    let refreshToken: String
}

final class LoginWebService: Routing {
    typealias DecodeType = TokenPair
    
    let baseURL: Config.Hostname = .sso
    let path: String = "/application-users/login"
    let authenticationType: AuthenticationType = .PublicKey
    
    let parameters: LoginWebServiceParameters?
    
    init(parameters: LoginWebServiceParameters) {
        self.parameters = parameters
    }
}

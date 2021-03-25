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

final class LoginWebService: Routing {
    typealias DecodeType = LoginWebServiceResponse
    
    var baseURL: Config.Hostname = .sso
    var path: String = "/application-users/login"
    var authenticationType: AuthenticationType = .PublicKey
    
    let parameters: LoginWebServiceParameters?
    let publicKey: String?
    
    init(publicKey: String, parameters: LoginWebServiceParameters) {
        self.publicKey = publicKey
        self.parameters = parameters
    }
}

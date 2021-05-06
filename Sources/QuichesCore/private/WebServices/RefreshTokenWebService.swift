//
//  File.swift
//  
//
//  Created by Maxence Mottard on 06/05/2021.
//

import Foundation

struct RefreshTokenServiceParameters: Encodable {
    let refreshToken: String
}

final class RefreshTokenWebService: Routing {
    typealias DecodeType = TokenPair
    
    let baseURL: Config.Hostname = .sso
    let path: String = "/application-users/refresh-token"
    let authenticationType: AuthenticationType = .PublicKey
    
    let parameters: RefreshTokenServiceParameters?
    
    init(parameters: RefreshTokenServiceParameters) {
        self.parameters = parameters
    }
}

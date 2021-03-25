//
//  File.swift
//  
//
//  Created by Maxence Mottard on 25/03/2021.
//

import Foundation

public struct User: Decodable {
    let token: String
    let refreshToken: String
}

class GetCurrentUserWebService: Routing {
    typealias ParameterTypes = EmptyCodable
    
    typealias DecodeType = User
    
    var baseURL: Config.Hostname = .sso
    var path: String = "/application-users/current"
    var authenticationType: AuthenticationType = .JWTBearer
}

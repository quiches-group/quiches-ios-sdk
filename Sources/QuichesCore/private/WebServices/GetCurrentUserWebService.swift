//
//  File.swift
//  
//
//  Created by Maxence Mottard on 25/03/2021.
//

import Foundation

public struct User: Decodable {
    let _id: String
    let mail: String
    let firstname: String
    let lastname: String
    let applicationId: String
}

class GetCurrentUserWebService: Routing {
    typealias ParameterTypes = EmptyCodable
    
    typealias DecodeType = User
    
    let baseURL: Config.Hostname = .sso
    let path: String = "/application-users/current"
    let authenticationType: AuthenticationType = .JWTBearer
    let method: HTTPMethod = .GET
}

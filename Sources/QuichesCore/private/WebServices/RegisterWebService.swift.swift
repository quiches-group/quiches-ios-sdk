//
//  File.swift
//  
//
//  Created by Zakarya TOLBA on 25/03/2021.
//

import Foundation

struct RegisterWebServiceParameters: Encodable {
    let mail: String
    let password: String
    let firstname: String
    let lastname: String
}

final class RegisterWebService: Routing {
    typealias DecodeType = EmptyCodable
    
    let baseURL: Config.Hostname = .sso
    let path: String = "/application-users"
    let authenticationType: AuthenticationType = .PublicKey
    let method: HTTPMethod = .PUT
    
    let parameters: RegisterWebServiceParameters?
    
    init(parameters: RegisterWebServiceParameters) {
        self.parameters = parameters
    }
}

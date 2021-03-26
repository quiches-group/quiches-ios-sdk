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
    
    var baseURL: Config.Hostname = .sso
    var path: String = "/application-users"
    var authenticationType: AuthenticationType = .none
    var method: HTTPMethod = .PUT
    
    let parameters: RegisterWebServiceParameters?
    
    init(parameters: RegisterWebServiceParameters) {
        self.parameters = parameters
    }
}
